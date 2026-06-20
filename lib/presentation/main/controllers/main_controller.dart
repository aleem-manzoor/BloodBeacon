import 'package:get/get.dart';
import 'package:ppsc_preparation/app/routes/app_pages.dart';
import 'package:ppsc_preparation/data/provider/local_storage/local_db.dart';

class MainController extends GetxController {
  //TODO: Implement MainController

  final count = 0.obs;

  Future logout() async {
    LocalDB.clear();
    Get.offAllNamed(Routes.LOGIN);
    update();
  }
}
