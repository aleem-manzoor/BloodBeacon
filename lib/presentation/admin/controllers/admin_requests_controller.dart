import 'package:get/get.dart';
import 'package:blood_beacon/app/utils/utils.dart';
import 'package:blood_beacon/data/model/blood_request_model.dart';
import 'package:blood_beacon/data/repositories/blood_request_repository.dart';

class AdminRequestsController extends GetxController {
  final BloodRequestRepository _repo = BloodRequestRepository();

  Stream<List<BloodRequestModel>> get requests => _repo.allRequests();

  Future<void> approve(String id) async {
    await _repo.updateModeration(id, 'approved');
    Utils.showToast(message: 'Request approved');
  }

  Future<void> reject(String id) async {
    await _repo.updateModeration(id, 'rejected');
    Utils.showToast(message: 'Request rejected');
  }

  Future<void> delete(String id) async {
    await _repo.delete(id);
    Utils.showToast(message: 'Request deleted');
  }
}
