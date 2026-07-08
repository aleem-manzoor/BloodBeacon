import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blood_beacon/app/services/location_service.dart';
import 'package:blood_beacon/app/services/session_service.dart';
import 'package:blood_beacon/app/utils/utils.dart';
import 'package:blood_beacon/data/repositories/user_repository.dart';

class EditProfileController extends GetxController {
  final SessionService session = Get.find<SessionService>();
  final LocationService _location = Get.find<LocationService>();
  final UserRepository _userRepository = UserRepository();

  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final ageController = TextEditingController();
  final cityController = TextEditingController();
  final eligibilityController = TextEditingController();

  final RxnString gender = RxnString();
  final RxnString bloodGroup = RxnString();
  final RxnDouble latitude = RxnDouble();
  final RxnDouble longitude = RxnDouble();
  final RxBool saving = false.obs;
  final RxBool capturingLocation = false.obs;

  @override
  void onInit() {
    super.onInit();
    final u = session.user.value;
    fullNameController.text = u?.fullName ?? '';
    phoneController.text = u?.phoneNumber ?? '';
    ageController.text = u?.age?.toString() ?? '';
    cityController.text = u?.city ?? '';
    eligibilityController.text = u?.medicalEligibility ?? '';
    gender.value = u?.gender;
    bloodGroup.value = u?.bloodGroup;
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
      final city = await _location.cityFromCoordinates(
          pos.latitude, pos.longitude);
      if (city != null && city.isNotEmpty) cityController.text = city;
      Utils.showToast(message: 'Location captured');
    } finally {
      capturingLocation.value = false;
    }
  }

  Future<void> save() async {
    if (!formKey.currentState!.validate()) return;
    final uid = session.user.value?.uid;
    if (uid == null) return;
    try {
      saving.value = true;
      await _userRepository.updateFields(uid, {
        'fullName': fullNameController.text.trim(),
        'phoneNumber': phoneController.text.trim(),
        'age': int.tryParse(ageController.text.trim()),
        'city': cityController.text.trim(),
        'gender': gender.value,
        'bloodGroup': bloodGroup.value,
        'medicalEligibility': eligibilityController.text.trim(),
        'latitude': latitude.value,
        'longitude': longitude.value,
      });
      Utils.showToast(message: 'Profile updated');
      Get.back();
    } catch (_) {
      Utils.showToast(message: 'Could not update profile');
    } finally {
      saving.value = false;
    }
  }
}
