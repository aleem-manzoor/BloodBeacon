import 'package:get/get.dart';

import '../controllers/favorites_controller.dart';
import '../controllers/hospitals_controller.dart';

class HospitalsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HospitalsController>(() => HospitalsController());
  }
}

class FavoritesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoritesController>(() => FavoritesController());
  }
}
