import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blood_beacon/app/config/global_var.dart';
import 'package:blood_beacon/app/routes/app_pages.dart';
import 'package:blood_beacon/app/utils/utils.dart';
import 'package:blood_beacon/data/model/user_model.dart';
import 'package:blood_beacon/data/provider/local_storage/local_db.dart';
import 'package:blood_beacon/data/repositories/authentication_repository.dart';

class OtpController extends GetxController {
  final TextEditingController otpController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  ProfileRepository profileRepository = ProfileRepository();

  RxBool showPassword = false.obs;
  String email = '';
  bool? fromRegister;
  final count = 0.obs;

  RxInt timerValue = 59.obs;
  Timer? countdownTimer;
  RxBool canResendOtp = false.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments['email'];
    fromRegister = Get.arguments['fromRegister'] == true ? true : false;

    log(fromRegister.toString());

    startTimer();
  }

  Future<void> otpVerification() async {
    if (isLoading.value) return;
    try {
      isLoading.value = true;
      final response = await profileRepository.otpVerification(
          email: email, otp: otpController.text);
      if (response != null) {
        if (response['success'] == true) {
          if (fromRegister != null && fromRegister == true) {
            UserModel user = UserModel.fromJson(response['data']);
            await LocalDB.setData('auth_token', user.access);
            Globals.authToken = await LocalDB.getData('auth_token');
            await LocalDB.setData('user_data', user.toJson());
            Globals.user = UserModel.fromJson(
                jsonDecode(await LocalDB.getData('user_data')));
            Get.offAllNamed(Routes.MAIN);
          } else {
            UserModel user = UserModel.fromJson(response['data']);
            Globals.authToken = user.access!;
            Get.toNamed(Routes.NEW_PASSWORD);
          }
          update();
        } else {
          Utils.showToast(message: response['message']);
        }
      } else {
        log('Registration failed with status: ${response.statusCode}');
        throw Exception('Failed to register: ${response.statusMessage}');
      }
    } catch (e) {
      log('-----String----${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendOtp() async {
    // try {
    final response = await profileRepository.forgetPasswordEmail(
      email: email,
    );
    if (response != null) {
      startTimer();
      if (response['success'] == true) {
        Utils.showToast(message: response['message']);
      } else {
        Utils.showToast(message: response['message']);
      }
    } else {
      log('Registration failed with status: ${response.statusCode}');
      throw Exception('Failed to register: ${response.statusMessage}');
    }
  }

  void startTimer() {
    timerValue.value = 59;
    canResendOtp.value = false;
    countdownTimer?.cancel();
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerValue.value > 0) {
        timerValue.value--;
      } else {
        canResendOtp.value = true;
        countdownTimer?.cancel();
      }
    });
    update();
  }

  @override
  void onClose() {
    countdownTimer?.cancel();
    super.onClose();
  }
}
