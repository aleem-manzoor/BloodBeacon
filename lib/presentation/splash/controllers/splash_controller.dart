import 'dart:convert';
import 'package:get/get.dart';
import 'package:ppsc_preparation/app/config/global_var.dart';
import 'package:ppsc_preparation/app/routes/app_pages.dart';
import 'package:ppsc_preparation/data/provider/local_storage/local_db.dart';
import '../../../data/model/user_model.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 3), () async {
      String? token = await LocalDB.getData('auth_token');
      String? isShown = await LocalDB.getData('onBoarding');

      if (token != null) {
        Globals.authToken = token;
        Globals.user =
            UserModel.fromJson(jsonDecode(await LocalDB.getData('user_data')));
        Get.offAndToNamed(Routes.MAIN);
      } else {
        if (isShown != null) {
          Get.offAllNamed(Routes.LOGIN);
        } else {
          // Get.offAndToNamed(Routes.ONBOARDING); //todo
        }
      }
    }); //todo

    super.onInit();
  }
}
