import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blood_beacon/app/config/app_enums.dart';
import 'package:blood_beacon/app/utils/utils.dart';
import 'package:blood_beacon/data/model/place_model.dart';
import 'package:blood_beacon/data/repositories/hospital_repository.dart';
import 'package:blood_beacon/data/seed/sample_blood_banks.dart';

class AdminHospitalsController extends GetxController {
  final HospitalRepository _repo = HospitalRepository();

  final Rx<PlaceType> type = PlaceType.hospital.obs;
  final RxBool saving = false.obs;
  final RxBool seeding = false.obs;

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final phoneController = TextEditingController();
  final latController = TextEditingController();
  final lngController = TextEditingController();

  Stream<List<PlaceModel>> get places => _repo.streamVerified(type.value);

  void setType(PlaceType value) {
    type.value = value;
    update();
  }

  void prefill(PlaceModel? place) {
    nameController.text = place?.name ?? '';
    addressController.text = place?.address ?? '';
    cityController.text = place?.city ?? '';
    phoneController.text = place?.phone ?? '';
    latController.text = place?.latitude?.toString() ?? '';
    lngController.text = place?.longitude?.toString() ?? '';
  }

  Future<void> save({String? id}) async {
    if (nameController.text.trim().isEmpty) {
      Utils.showToast(message: 'Name is required');
      return;
    }
    try {
      saving.value = true;
      final place = PlaceModel(
        name: nameController.text.trim(),
        address: addressController.text.trim(),
        city: cityController.text.trim(),
        phone: phoneController.text.trim(),
        latitude: double.tryParse(latController.text.trim()),
        longitude: double.tryParse(lngController.text.trim()),
        type: type.value == PlaceType.hospital ? 'Hospital' : 'Blood Bank',
        verified: true,
      );
      if (id == null) {
        await _repo.create(type.value, place);
      } else {
        await _repo.update(type.value, id, place);
      }
      Get.back();
      Utils.showToast(message: 'Saved');
    } catch (_) {
      Utils.showToast(message: 'Could not save');
    } finally {
      saving.value = false;
    }
  }

  Future<void> toggleVerified(PlaceModel place) async {
    if (place.id == null) return;
    await _repo.setVerified(type.value, place.id!, !place.verified);
    Utils.showToast(message: place.verified ? 'Unverified' : 'Verified');
  }

  Future<void> delete(String id) async {
    await _repo.delete(type.value, id);
    Utils.showToast(message: 'Deleted');
  }

  Future<void> seedSampleBloodBanks() async {
    try {
      seeding.value = true;
      for (final entry in sampleBloodBanks.entries) {
        await _repo.upsert(PlaceType.bloodBank, entry.key, entry.value);
      }
      type.value = PlaceType.bloodBank;
      update();
      Utils.showToast(
          message: '${sampleBloodBanks.length} sample blood banks added');
    } catch (_) {
      Utils.showToast(message: 'Could not seed blood banks');
    } finally {
      seeding.value = false;
    }
  }
}
