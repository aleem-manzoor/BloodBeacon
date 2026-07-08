import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blood_beacon/app/services/location_service.dart';
import 'package:blood_beacon/app/services/session_service.dart';
import 'package:blood_beacon/app/utils/utils.dart';
import 'package:blood_beacon/data/model/blood_request_model.dart';
import 'package:blood_beacon/data/model/notification_model.dart';
import 'package:blood_beacon/data/repositories/blood_request_repository.dart';
import 'package:blood_beacon/data/repositories/notification_repository.dart';
import 'package:blood_beacon/data/repositories/user_repository.dart';

class CreateRequestController extends GetxController {
  final SessionService session = Get.find<SessionService>();
  final LocationService _location = Get.find<LocationService>();
  final BloodRequestRepository _requestRepo = BloodRequestRepository();
  final NotificationRepository _notificationRepo = NotificationRepository();
  final UserRepository _userRepository = UserRepository();

  final formKey = GlobalKey<FormState>();
  final patientNameController = TextEditingController();
  final unitsController = TextEditingController(text: '1');
  final hospitalNameController = TextEditingController();
  final hospitalAddressController = TextEditingController();
  final notesController = TextEditingController();

  final RxnString bloodGroup = RxnString();
  final RxnDouble latitude = RxnDouble();
  final RxnDouble longitude = RxnDouble();
  final RxBool saving = false.obs;
  final RxBool capturingLocation = false.obs;

  @override
  void onInit() {
    super.onInit();
    final u = session.user.value;
    latitude.value = u?.latitude;
    longitude.value = u?.longitude;
  }

  Future<void> captureLocation() async {
    try {
      capturingLocation.value = true;
      final pos = await _location.getCurrentPosition();
      if (pos == null) {
        Utils.showToast(message: 'Enable location permission to continue');
        return;
      }
      latitude.value = pos.latitude;
      longitude.value = pos.longitude;
      final address = await _location.cityFromCoordinates(
          pos.latitude, pos.longitude);
      if (address != null && hospitalAddressController.text.isEmpty) {
        hospitalAddressController.text = address;
      }
      Utils.showToast(message: 'Location captured');
    } finally {
      capturingLocation.value = false;
    }
  }

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;
    if (bloodGroup.value == null) {
      Utils.showToast(message: 'Please select a blood group');
      return;
    }
    final user = session.user.value;
    if (user?.uid == null) return;
    try {
      saving.value = true;
      final request = BloodRequestModel(
        patientName: patientNameController.text.trim(),
        bloodGroup: bloodGroup.value,
        units: int.tryParse(unitsController.text.trim()) ?? 1,
        hospitalName: hospitalNameController.text.trim(),
        hospitalAddress: hospitalAddressController.text.trim(),
        notes: notesController.text.trim(),
        latitude: latitude.value,
        longitude: longitude.value,
        status: 'pending',
        moderationStatus: 'approved',
        createdBy: user!.uid,
        createdByName: user.fullName,
        creatorPhone: user.phoneNumber,
        createdAt: DateTime.now().toIso8601String(),
      );
      await _requestRepo.create(request);
      await _notifyDonors(request);
      Utils.showToast(message: 'Emergency request created');
      Get.back();
    } catch (_) {
      Utils.showToast(message: 'Could not create request');
    } finally {
      saving.value = false;
    }
  }

  Future<void> _notifyDonors(BloodRequestModel request) async {
    try {
      final donors =
          await _userRepository.getAvailableDonors(bloodGroup: request.bloodGroup);
      for (final donor in donors) {
        if (donor.uid == null || donor.uid == request.createdBy) continue;
        await _notificationRepo.add(
          donor.uid!,
          NotificationModel(
            title: 'Urgent: ${request.bloodGroup} blood needed',
            body:
                '${request.hospitalName} needs ${request.units} unit(s). Tap to help.',
            type: 'emergency',
            userId: donor.uid,
            createdAt: DateTime.now().toIso8601String(),
          ),
        );
      }
    } catch (_) {}
  }
}
