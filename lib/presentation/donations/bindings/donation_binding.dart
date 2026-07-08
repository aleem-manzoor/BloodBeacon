import 'package:get/get.dart';

import '../controllers/donation_history_controller.dart';

class DonationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DonationHistoryController>(() => DonationHistoryController());
  }
}
