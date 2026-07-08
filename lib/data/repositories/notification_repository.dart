import 'package:blood_beacon/app/config/app_constants.dart';
import 'package:blood_beacon/data/model/notification_model.dart';
import 'package:blood_beacon/data/provider/firebase/firestore_service.dart';

class NotificationRepository {
  final FirestoreService _firestore = FirestoreService();

  Future<String> add(String userId, NotificationModel notification) =>
      _firestore.addToUserSub(userId, FirestoreCollections.notifications,
          notification.toFirestore());

  Stream<List<NotificationModel>> notifications(String userId) {
    return _firestore
        .streamUserSubList(userId, FirestoreCollections.notifications)
        .map((list) => list.map(NotificationModel.fromMap).toList());
  }

  Future<void> markRead(String userId, String id) => _firestore.userSub(
        userId,
        FirestoreCollections.notifications,
      ).doc(id).update({'read': true});

  Future<void> delete(String userId, String id) =>
      _firestore.deleteUserSub(userId, FirestoreCollections.notifications, id);
}
