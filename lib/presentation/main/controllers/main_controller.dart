import 'package:get/get.dart';
import 'package:blood_beacon/app/routes/app_pages.dart';
import 'package:blood_beacon/app/services/session_service.dart';

class MainController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void changeTab(int index) => currentIndex.value = index;

  Future<void> logout() async {
    await Get.find<SessionService>().signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
