import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ppsc_preparation/app/routes/app_pages.dart';
import 'package:ppsc_preparation/app/utils/utils.dart';
import 'package:ppsc_preparation/data/provider/firebase/firebase_auth_service.dart';

class SignupController extends GetxController {
  final count = 0.obs;
  final loginFormKey = GlobalKey<FormState>();

  final FirebaseAuthService _authService = FirebaseAuthService();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxBool showPassword = false.obs;
  RxBool showConfirmPassword = false.obs;
  bool isReceiveEmail = false;

  Future<void> register(
      {required String phoneNumber,
      required String firstName,
      required String lastName,
      required String email,
      required password}) async {
    try {
      await _authService.register(
        email: email,
        password: password,
        displayName: '$firstName $lastName',
      );
      Utils.showToast(message: 'Account created successfully. Please log in.');
      Get.offAllNamed(Routes.LOGIN);
    } on FirebaseAuthException catch (e) {
      Utils.showToast(message: FirebaseAuthService.messageFromException(e));
    } catch (e) {
      log('-----Register error----${e.toString()}');
      Utils.showToast(message: 'Something went wrong. Please try again.');
    }
  }
}
