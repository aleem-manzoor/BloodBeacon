import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blood_beacon/app/routes/app_pages.dart';
import 'package:blood_beacon/app/services/session_service.dart';
import 'package:blood_beacon/app/utils/utils.dart';
import 'package:blood_beacon/data/model/user_model.dart';
import 'package:blood_beacon/data/provider/firebase/firebase_auth_service.dart';
import 'package:blood_beacon/data/repositories/user_repository.dart';

class SignupController extends GetxController {
  final count = 0.obs;
  final loginFormKey = GlobalKey<FormState>();

  final FirebaseAuthService _authService = FirebaseAuthService();
  final UserRepository _userRepository = UserRepository();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxBool showPassword = false.obs;
  RxBool showConfirmPassword = false.obs;
  RxBool isLoading = false.obs;
  bool isReceiveEmail = false;

  Future<void> register({
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required String email,
    required password,
  }) async {
    if (isLoading.value) return;
    try {
      isLoading.value = true;
      final credential = await _authService.register(
        email: email,
        password: password,
        displayName: '$firstName $lastName',
      );
      final uid = credential.user?.uid;
      if (uid == null) {
        Utils.showToast(message: 'Something went wrong. Please try again.');
        return;
      }
      final user = UserModel(
        uid: uid,
        fullName: '$firstName $lastName'.trim(),
        email: email,
        phoneNumber: phoneNumber,
        role: 'user',
        isDonor: false,
        isAvailable: false,
        isDisabled: false,
        createdAt: DateTime.now().toIso8601String(),
      );
      await _userRepository.createOrUpdateProfile(user);
      await Get.find<SessionService>().load(uid);
      Utils.showToast(message: 'Account created successfully');
      Get.offAllNamed(Routes.MAIN);
    } on FirebaseAuthException catch (e) {
      Utils.showToast(message: FirebaseAuthService.messageFromException(e));
    } catch (e) {
      log('-----Register error----${e.toString()}');
      Utils.showToast(message: 'Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }
}
