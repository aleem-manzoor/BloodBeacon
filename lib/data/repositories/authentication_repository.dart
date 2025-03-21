import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:ppsc_preparation/app/config/global_var.dart';

import '../provider/network/api_endpoint.dart';
import '../provider/network/api_provider.dart';

class ProfileRepository {
  late APIProvider apiClient;

  ProfileRepository() {
    apiClient = APIProvider();
  }

  Future signInAccount({String? email, String? password}) async {
    Map<String, dynamic>? data = await apiClient.basePostAPI(
      ApiEndPoints.login,
      {
        "email": email,
        "password": password,
        "role": "customer",
      },
      false,
      loading: true,
      Get.context,
    );
    return data;
  }

  Future registerAccount(
      {required String email,
      required String password,
      required String lastName,
      required String firstName,
      required String phone}) async {
    Map<String, dynamic>? data = await apiClient.basePostAPI(
      ApiEndPoints.register,
      {
        "email": email,
        "phone_number": phone,
        "first_name": firstName,
        "last_name": lastName,
        "password": password,
        "role": "customer",
      },
      false,
      loading: true,
      Get.context,
    );
    return data;
  }

  Future otpVerification({String? email, String? otp}) async {
    Map<String, dynamic>? data = await apiClient.basePostAPI(
      ApiEndPoints.otpVerification,
      {
        "email": email,
        "otp": otp,
        "role": "customer",
      },
      false,
      loading: true,
      Get.context,
    );
    return data;
  }

  Future updateAccount(
      {required File file,
      required String expertise,
      required String title,
      required String acountType,
      String? userName}) async {
    Map<String, dynamic>? data = await apiClient.baseMultipartPersonalInfo(
      ApiEndPoints.updateUser,
      {
        "user_name": userName,
        "title": title,
        "expertise": expertise,
        "account_type": "personal",
      },
      file,
      Get.context,
    );
    return data;
  }

  Future forgetPasswordEmail({String? email, String? password}) async {
    Map<String, dynamic>? data = await apiClient.basePostAPI(
      ApiEndPoints.forgetPasswordEmail,
      {"email": email, "role": 'customer'},
      false,
      loading: true,
      Get.context,
    );
    return data;
  }

  Future resetPassword({required String password}) async {
    Map<String, dynamic>? data = await apiClient.basePostAPI(
      ApiEndPoints.resetPassword,
      {"password": password},
      true,
      loading: true,
      Get.context,
    );
    return data;
  }

  Future externalLoginCallBack(
      {String? name,
      String? num,
      String? accessToken,
      String? idToken,
      String? fcmToken,
      String? provider,
      String? email,
      String? photo}) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        ApiEndPoints.externalLoginCallBack,
        {
          "token": idToken ?? "",
          "fcm_token": Globals.fcmToken,
          "device_id": Globals.deviceId,
          "device_name": Globals.deviceName,
          "login_device": Globals.loginDevice,
          "app_version": Globals.appVersion,
          "build_number": Globals.buildNumber,
        },
        false,
        loading: true,
        Get.context);
    return data;
  }

  Future appleLogin({
    String? name,
    String? idToken,
  }) async {
    log('inside appleLogin function');
    Map<String, dynamic> data = await apiClient.basePostAPI(
        ApiEndPoints.appleLogin,
        {
          "token": idToken ?? "",
          "first_name": name ?? "",
          "last_name": name ?? "",
          "fcm_token": Globals.fcmToken,
          "device_id": Globals.deviceId,
          "device_name": Globals.deviceName,
          "login_device": Globals.loginDevice,
          "app_version": Globals.appVersion,
          "build_number": Globals.buildNumber,
        },
        false,
        loading: true,
        Get.context);
    return data;
  }
}
