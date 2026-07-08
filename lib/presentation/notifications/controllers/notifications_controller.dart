import 'package:get/get.dart';
import 'package:blood_beacon/app/services/session_service.dart';
import 'package:blood_beacon/data/model/notification_model.dart';
import 'package:blood_beacon/data/repositories/notification_repository.dart';

class NotificationsController extends GetxController {
  final SessionService session = Get.find<SessionService>();
  final NotificationRepository _repo = NotificationRepository();

  String get uid => session.user.value?.uid ?? '';

  Stream<List<NotificationModel>> get notifications =>
      _repo.notifications(uid);

  Future<void> markRead(String id) => _repo.markRead(uid, id);
  Future<void> delete(String id) => _repo.delete(uid, id);
}
