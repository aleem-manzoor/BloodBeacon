import 'package:get/get.dart';

import '../controllers/admin_announcements_controller.dart';
import '../controllers/admin_controller.dart';
import '../controllers/admin_hospitals_controller.dart';
import '../controllers/admin_reports_controller.dart';
import '../controllers/admin_requests_controller.dart';
import '../controllers/admin_users_controller.dart';

class AdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminController>(() => AdminController());
  }
}

class AdminUsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminUsersController>(() => AdminUsersController());
  }
}

class AdminRequestsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminRequestsController>(() => AdminRequestsController());
  }
}

class AdminHospitalsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminHospitalsController>(() => AdminHospitalsController());
  }
}

class AdminReportsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminReportsController>(() => AdminReportsController());
  }
}

class AdminAnnouncementsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminAnnouncementsController>(
        () => AdminAnnouncementsController());
  }
}
