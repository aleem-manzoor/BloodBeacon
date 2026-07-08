import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blood_beacon/app/config/global_var.dart';
import 'package:blood_beacon/app/routes/app_pages.dart';
import 'package:blood_beacon/app/services/session_service.dart';
import 'package:blood_beacon/app/utils/utils.dart';
import 'package:blood_beacon/data/model/user_model.dart';
import 'package:blood_beacon/data/provider/firebase/firebase_auth_service.dart';
import 'package:blood_beacon/data/provider/local_storage/local_db.dart';
import 'package:blood_beacon/data/repositories/user_repository.dart';

class LoginController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuthService _authService = FirebaseAuthService();
  final UserRepository _userRepository = UserRepository();

  RxBool keepMeSignedIn = false.obs;
  RxBool showPassword = false.obs;
  RxBool isLoading = false.obs;

  bool isReceiveEmail = false;
  bool savePassword = false;

  Future<void> login(String email, String password) async {
    if (isLoading.value) return;
    try {
      isLoading.value = true;
      final credential =
          await _authService.login(email: email, password: password);
      final user = credential.user;
      if (user == null) return;

      final token = await user.getIdToken() ?? '';
      Globals.authToken = token;
      Globals.userId = user.uid;
      Globals.email = user.email;

      var profile = await _userRepository.getProfile(user.uid);
      if (profile == null) {
        profile = UserModel(
          uid: user.uid,
          fullName: user.displayName ?? '',
          email: user.email,
          role: 'user',
          isDonor: false,
          isAvailable: false,
          isDisabled: false,
          createdAt: DateTime.now().toIso8601String(),
        );
        await _userRepository.createOrUpdateProfile(profile);
      }

      if (profile.isDisabled == true) {
        await _authService.logout();
        Utils.showToast(message: 'This account has been disabled.');
        return;
      }

      await Get.find<SessionService>().load(user.uid);
      if (savePassword || keepMeSignedIn.value) {
        await LocalDB.setData('auth_token', token);
      }

      Utils.showToast(message: 'Logged in successfully');
      Get.offAllNamed(profile.isAdmin ? Routes.ADMIN : Routes.MAIN);
    } on FirebaseAuthException catch (e) {
      Utils.showToast(message: FirebaseAuthService.messageFromException(e));
    } catch (e) {
      log('-----Login error----${e.toString()}');
      Utils.showToast(message: 'Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }
}
