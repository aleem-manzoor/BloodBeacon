import 'package:get/get.dart';
import 'package:ppsc_preparation/app/routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(Routes.LOGIN);
    });

    super.onInit();
  }
}
