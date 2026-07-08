import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blood_beacon/app/config/app_constants.dart';
import 'package:blood_beacon/app/services/session_service.dart';
import 'package:blood_beacon/app/utils/utils.dart';
import 'package:blood_beacon/data/model/donation_model.dart';
import 'package:blood_beacon/data/repositories/donation_repository.dart';
import 'package:blood_beacon/data/repositories/user_repository.dart';

class DonationHistoryController extends GetxController {
  final SessionService session = Get.find<SessionService>();
  final DonationRepository _repo = DonationRepository();
  final UserRepository _userRepository = UserRepository();

  final RxList<DonationModel> donations = <DonationModel>[].obs;
  final RxBool loading = false.obs;
  final RxBool saving = false.obs;

  final hospitalController = TextEditingController();
  final unitsController = TextEditingController(text: '1');
  final RxnString date = RxnString();

  String get uid => session.user.value?.uid ?? '';

  int get total => donations.length;

  DateTime? get lastDonation {
    if (donations.isEmpty) return null;
    final dates = donations
        .map((d) => DateTime.tryParse(d.date ?? ''))
        .whereType<DateTime>()
        .toList()
      ..sort();
    return dates.isEmpty ? null : dates.last;
  }

  DateTime? get nextEligible => lastDonation
      ?.add(const Duration(days: AppConstants.donationCooldownDays));

  bool get isEligible =>
      nextEligible == null || DateTime.now().isAfter(nextEligible!);

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    try {
      loading.value = true;
      donations.assignAll(await _repo.getUserDonations(uid));
    } finally {
      loading.value = false;
    }
  }

  Future<void> pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: Get.context!,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: now,
    );
    if (picked != null) date.value = picked.toIso8601String();
  }

  Future<void> addDonation() async {
    if (date.value == null || hospitalController.text.trim().isEmpty) {
      Utils.showToast(message: 'Please add date and hospital');
      return;
    }
    try {
      saving.value = true;
      await _repo.add(
        uid,
        DonationModel(
          date: date.value,
          hospital: hospitalController.text.trim(),
          bloodGroup: session.user.value?.bloodGroup,
          units: int.tryParse(unitsController.text.trim()) ?? 1,
          userId: uid,
        ),
      );
      await _userRepository
          .updateFields(uid, {'lastDonationDate': date.value});
      hospitalController.clear();
      unitsController.text = '1';
      date.value = null;
      Get.back();
      Utils.showToast(message: 'Donation recorded');
      await load();
    } catch (_) {
      Utils.showToast(message: 'Could not save donation');
    } finally {
      saving.value = false;
    }
  }
}
