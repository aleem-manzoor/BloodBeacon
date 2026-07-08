import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:blood_beacon/app/services/session_service.dart';
import 'package:blood_beacon/app/utils/utils.dart';
import 'package:blood_beacon/data/model/blood_request_model.dart';
import 'package:blood_beacon/data/model/report_model.dart';
import 'package:blood_beacon/data/repositories/blood_request_repository.dart';
import 'package:blood_beacon/data/repositories/report_repository.dart';

class RequestDetailController extends GetxController {
  final SessionService session = Get.find<SessionService>();
  final BloodRequestRepository _requestRepo = BloodRequestRepository();
  final ReportRepository _reportRepo = ReportRepository();

  late final Rx<BloodRequestModel> request;
  final RxBool busy = false.obs;

  @override
  void onInit() {
    super.onInit();
    request = (Get.arguments as BloodRequestModel).obs;
  }

  bool get isOwner => request.value.createdBy == session.user.value?.uid;

  Future<void> cancel() async {
    final id = request.value.id;
    if (id == null) return;
    try {
      busy.value = true;
      await _requestRepo.updateStatus(id, 'cancelled');
      request.value = BloodRequestModel(
        id: request.value.id,
        patientName: request.value.patientName,
        bloodGroup: request.value.bloodGroup,
        units: request.value.units,
        hospitalName: request.value.hospitalName,
        hospitalAddress: request.value.hospitalAddress,
        notes: request.value.notes,
        latitude: request.value.latitude,
        longitude: request.value.longitude,
        status: 'cancelled',
        moderationStatus: request.value.moderationStatus,
        createdBy: request.value.createdBy,
        createdByName: request.value.createdByName,
        creatorPhone: request.value.creatorPhone,
        createdAt: request.value.createdAt,
      );
      Utils.showToast(message: 'Request cancelled');
    } catch (_) {
      Utils.showToast(message: 'Could not cancel request');
    } finally {
      busy.value = false;
    }
  }

  Future<void> callCreator() async {
    final phone = request.value.creatorPhone;
    if (phone == null || phone.isEmpty) {
      Utils.showToast(message: 'No contact number available');
      return;
    }
    final uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Utils.showToast(message: 'Could not start a call');
    }
  }

  Future<void> navigate() async {
    final r = request.value;
    if (r.latitude == null || r.longitude == null) {
      Utils.showToast(message: 'No location attached');
      return;
    }
    final uri = Uri.parse(
        'https://www.openstreetmap.org/directions?to=${r.latitude}%2C${r.longitude}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> report(String reason) async {
    try {
      await _reportRepo.create(ReportModel(
        reportedUserId: request.value.createdBy,
        reportedUserName: request.value.createdByName,
        reason: reason,
        details: 'Reported from blood request: ${request.value.id}',
        status: 'pending',
        reportedBy: session.user.value?.uid,
        createdAt: DateTime.now().toIso8601String(),
      ));
      Utils.showToast(message: 'Report submitted. Thank you.');
    } catch (_) {
      Utils.showToast(message: 'Could not submit report');
    }
  }
}
