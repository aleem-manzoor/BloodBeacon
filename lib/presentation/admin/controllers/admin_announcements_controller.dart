import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blood_beacon/app/services/session_service.dart';
import 'package:blood_beacon/app/utils/utils.dart';
import 'package:blood_beacon/data/model/announcement_model.dart';
import 'package:blood_beacon/data/repositories/announcement_repository.dart';

class AdminAnnouncementsController extends GetxController {
  final AnnouncementRepository _repo = AnnouncementRepository();
  final SessionService session = Get.find<SessionService>();

  final titleController = TextEditingController();
  final messageController = TextEditingController();
  final RxString type = 'Announcement'.obs;
  final RxBool saving = false.obs;

  final List<String> types = [
    'Announcement',
    'Blood Donation Camp',
    'Emergency Blood Shortage',
    'Health Awareness',
  ];

  Stream<List<AnnouncementModel>> get announcements => _repo.announcements();

  Future<void> publish() async {
    if (titleController.text.trim().isEmpty ||
        messageController.text.trim().isEmpty) {
      Utils.showToast(message: 'Title and message are required');
      return;
    }
    try {
      saving.value = true;
      await _repo.create(AnnouncementModel(
        title: titleController.text.trim(),
        message: messageController.text.trim(),
        type: type.value,
        createdBy: session.user.value?.uid,
        createdAt: DateTime.now().toIso8601String(),
      ));
      titleController.clear();
      messageController.clear();
      Get.back();
      Utils.showToast(message: 'Announcement published');
    } catch (_) {
      Utils.showToast(message: 'Could not publish');
    } finally {
      saving.value = false;
    }
  }

  Future<void> delete(String id) async {
    await _repo.delete(id);
    Utils.showToast(message: 'Deleted');
  }
}
