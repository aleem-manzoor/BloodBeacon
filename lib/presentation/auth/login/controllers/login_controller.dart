import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ppsc_preparation/app/config/global_var.dart';
import 'package:ppsc_preparation/app/routes/app_pages.dart';
import 'package:ppsc_preparation/app/utils/utils.dart';
import 'package:ppsc_preparation/data/provider/firebase/firebase_auth_service.dart';
import 'package:ppsc_preparation/data/provider/local_storage/local_db.dart';

class LoginController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuthService _authService = FirebaseAuthService();

  RxBool keepMeSignedIn = false.obs;
  RxBool showPassword = false.obs;

  bool isReceiveEmail = false;
  bool savePassword = false;

  Future<void> login(String email, String password) async {
    try {
      final credential =
          await _authService.login(email: email, password: password);
      final user = credential.user;
      if (user != null) {
        final token = await user.getIdToken() ?? '';
        Globals.authToken = token;
        Globals.userId = user.uid;
        Globals.email = user.email;
        Globals.fullName = user.displayName ?? '';

        if (savePassword || keepMeSignedIn.value) {
          await LocalDB.setData('auth_token', token);
        }

        Utils.showToast(message: 'Logged in successfully');
        Get.offAllNamed(Routes.MAIN);
      }
    } on FirebaseAuthException catch (e) {
      Utils.showToast(message: FirebaseAuthService.messageFromException(e));
    } catch (e) {
      log('-----Login error----${e.toString()}');
      Utils.showToast(message: 'Something went wrong. Please try again.');
    }
  }
}
