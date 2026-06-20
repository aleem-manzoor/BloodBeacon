import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ppsc_preparation/app/routes/app_pages.dart';
import 'package:ppsc_preparation/app/utils/utils.dart';
import 'package:ppsc_preparation/data/repositories/authentication_repository.dart';

class NewPasswordController extends GetxController {
  final newFormKey = GlobalKey<FormState>();
  ProfileRepository profileRepository = ProfileRepository();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool showPassword = false.obs;
  RxBool showConfirmPassword = false.obs;
  String email = '';

  Future<void> setPassword() async {
    try {
      final response = await profileRepository.resetPassword(
        password: passwordController.text.trim(),
      );

      log(response.toString());

      if (response != null) {
        if (response['success'] == true && response['data'] != null) {
          Utils.showToast(message: response['message']);
          Get.offAllNamed(Routes.LOGIN);
        } else {
          Utils.showToast(message: response['message']);
        }
      } else {
        log('Registration failed with status: ${response.statusCode}');
        throw Exception('Failed to register: ${response.statusMessage}');
      }
    } catch (e) {
      log('-----String----${e.toString()}');
    }
  }
}
