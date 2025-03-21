import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ppsc_preparation/app/routes/app_pages.dart';
import 'package:ppsc_preparation/app/utils/utils.dart';
import 'package:ppsc_preparation/data/repositories/authentication_repository.dart';

class SignupController extends GetxController {
  //TODO: Implement SignupController

  final count = 0.obs;
  final loginFormKey = GlobalKey<FormState>();

  ProfileRepository profileRepository = ProfileRepository();

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
      final response = await profileRepository.registerAccount(
          email: email,
          phone: phoneNumber,
          firstName: firstName,
          lastName: lastName,
          password: password);
      if (response != null) {
        if (response['success'] == true) {
          Get.toNamed(Routes.OTP,
              arguments: {"email": email.trim(), "fromRegister": true});
          Utils.showToast(message: response['message']);
        } else if (response['success'] == false &&
            response['message'] ==
                'Phone number already linked with another account') {
          Utils.showToast(
              message:
                  'This phone number is already linked with another account. Please use another number.');
        } else if (response['success'] == false &&
            response['message'] == 'User already exists') {
          Utils.showToast(
              message:
                  'This email is already registered. Please log in or reset your password.');
        } else {
          Utils.showToast(message: response['message']);
        }
      } else {
        log('Registration failed with status: ${response.statusCode}');
        Utils.showToast(message: response['message']);
        throw Exception('Failed to register: ${response.statusMessage}');
      }
    } catch (e) {
      log('-----String----${e.toString()}');
    }
  }
}
