import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blood_beacon/app/routes/app_pages.dart';
import 'package:blood_beacon/app/services/location_service.dart';
import 'package:blood_beacon/app/services/session_service.dart';
import 'package:blood_beacon/app/utils/utils.dart';
import 'package:blood_beacon/data/repositories/user_repository.dart';

class BecomeDonorController extends GetxController {
  final SessionService session = Get.find<SessionService>();
  final LocationService _location = Get.find<LocationService>();
  final UserRepository _userRepository = UserRepository();

  final eligibilityController = TextEditingController();
  final RxnString bloodGroup = RxnString();
  final RxnString lastDonationDate = RxnString();
  final RxBool available = true.obs;
  final RxnDouble latitude = RxnDouble();
  final RxnDouble longitude = RxnDouble();
  final RxnString city = RxnString();
  final RxBool saving = false.obs;
  final RxBool capturingLocation = false.obs;

  @override
  void onInit() {
    super.onInit();
    final u = session.user.value;
    bloodGroup.value = u?.bloodGroup;
    lastDonationDate.value = u?.lastDonationDate;
    eligibilityController.text = u?.medicalEligibility ?? '';
    available.value = u?.isAvailable ?? true;
    latitude.value = u?.latitude;
    longitude.value = u?.longitude;
    city.value = u?.city;
  }

  Future<void> pickLastDonationDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: Get.context!,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: now,
    );
    if (picked != null) {
      lastDonationDate.value = picked.toIso8601String();
    }
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
      city.value = await _location.cityFromCoordinates(
          pos.latitude, pos.longitude);
      Utils.showToast(message: 'Location captured');
    } finally {
      capturingLocation.value = false;
    }
  }

  Future<void> submit() async {
    if (bloodGroup.value == null) {
      Utils.showToast(message: 'Please select your blood group');
      return;
    }
    if (latitude.value == null || longitude.value == null) {
      Utils.showToast(message: 'Please capture your location');
      return;
    }
    final uid = session.user.value?.uid;
    if (uid == null) return;
    try {
      saving.value = true;
      await _userRepository.updateFields(uid, {
        'isDonor': true,
        'isAvailable': available.value,
        'bloodGroup': bloodGroup.value,
        'lastDonationDate': lastDonationDate.value,
        'medicalEligibility': eligibilityController.text.trim(),
        'latitude': latitude.value,
        'longitude': longitude.value,
        'city': city.value,
      });
      Utils.showToast(message: 'You are now registered as a donor');
      Get.offNamedUntil(Routes.MAIN, (route) => false);
    } catch (_) {
      Utils.showToast(message: 'Could not complete registration');
    } finally {
      saving.value = false;
    }
  }
}
