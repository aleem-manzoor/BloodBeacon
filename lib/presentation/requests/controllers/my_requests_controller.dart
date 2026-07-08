import 'package:get/get.dart';
import 'package:blood_beacon/app/routes/app_pages.dart';
import 'package:blood_beacon/app/services/session_service.dart';
import 'package:blood_beacon/app/utils/utils.dart';
import 'package:blood_beacon/data/model/blood_request_model.dart';
import 'package:blood_beacon/data/repositories/blood_request_repository.dart';

class MyRequestsController extends GetxController {
  final SessionService session = Get.find<SessionService>();
  final BloodRequestRepository _repo = BloodRequestRepository();

  String get uid => session.user.value?.uid ?? '';

  Stream<List<BloodRequestModel>> get myRequests => _repo.myRequests(uid);

  Future<void> cancelRequest(String id) async {
    try {
      await _repo.updateStatus(id, 'cancelled');
      Utils.showToast(message: 'Request cancelled');
    } catch (_) {
      Utils.showToast(message: 'Could not cancel request');
    }
  }

  void goCreate() => Get.toNamed(Routes.CREATE_REQUEST);
  void openDetail(BloodRequestModel request) =>
      Get.toNamed(Routes.REQUEST_DETAIL, arguments: request);
}
