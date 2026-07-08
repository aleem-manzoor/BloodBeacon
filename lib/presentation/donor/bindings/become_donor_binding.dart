import 'package:get/get.dart';

import '../controllers/become_donor_controller.dart';

class BecomeDonorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BecomeDonorController>(() => BecomeDonorController());
  }
}
