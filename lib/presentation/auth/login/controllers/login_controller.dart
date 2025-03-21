import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ppsc_preparation/app/config/global_var.dart';
import 'package:ppsc_preparation/app/routes/app_pages.dart';
import 'package:ppsc_preparation/app/utils/utils.dart';
import 'package:ppsc_preparation/data/model/user_model.dart';
import 'package:ppsc_preparation/data/provider/local_storage/local_db.dart';
import 'package:ppsc_preparation/data/repositories/authentication_repository.dart';

class LoginController extends GetxController {
//  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  final loginFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ProfileRepository profileRepository = ProfileRepository();

  RxBool keepMeSignedIn = false.obs;

  RxBool showPassword = false.obs;

  bool isReceiveEmail = false;
  bool savePassword = false;

  Future<void> login(String email, String password) async {
    try {
      final response = await profileRepository.signInAccount(
          email: email, password: password);
      log(response.toString());
      if (response != null) {
        if (response['success'] == true && response['data'] != null) {
          log(response.toString());
          UserModel user = UserModel.fromJson(response['data']);
          if (user.access != null) {
            Globals.authToken = user.access!;
            if (savePassword) {
              await LocalDB.setData('auth_token', user.access!);
              Globals.authToken = await LocalDB.getData('auth_token');
              await LocalDB.setData('user_data', user.toJson());
              Globals.user = UserModel.fromJson(
                  jsonDecode(await LocalDB.getData('user_data')));
            } else {
              Globals.user = user;
            }
            Utils.showToast(message: response['message']);
            Get.offAllNamed(Routes.MAIN);
            log(Globals.user!.toJson().toString());
          }
        } else if (response != null && response['success'] == false) {
          if (response['message'] == "Please verify your OTP first") {
            Get.offNamed(Routes.OTP,
                arguments: {"email": email.trim(), "fromRegister": true});
            Utils.showToast(
                message: "Otp sent successfully to your given email");
          } else {
            Utils.showToast(message: response['message']);
          }
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
