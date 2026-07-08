import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blood_beacon/app/routes/app_pages.dart';
import 'package:blood_beacon/app/utils/utils.dart';
import 'package:blood_beacon/data/repositories/authentication_repository.dart';

class ForgotPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  ProfileRepository profileRepository = ProfileRepository();
  TextEditingController emailController = TextEditingController();

  RxBool isLoading = false.obs;

  Future<void> forgetPassword() async {
    if (isLoading.value) return;
    try {
      isLoading.value = true;
      final response = await profileRepository.forgetPasswordEmail(
        email: emailController.text.trim(),
      );
      if (response != null) {
        if (response['success'] == true) {
          Get.toNamed(Routes.OTP, arguments: {
            "email": emailController.text.trim(),
            "fromRegister": false
          });
        } else {
          Utils.showToast(message: response['message']);
        }
      } else {
        log('Registration failed with status: ${response.statusCode}');
        throw Exception('Failed to register: ${response.statusMessage}');
      }
    } catch (e) {
      log('Registration failed with status: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }
}
