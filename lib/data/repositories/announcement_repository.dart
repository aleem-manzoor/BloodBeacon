import 'package:blood_beacon/app/config/app_constants.dart';
import 'package:blood_beacon/data/model/announcement_model.dart';
import 'package:blood_beacon/data/provider/firebase/firestore_service.dart';

class AnnouncementRepository {
  final FirestoreService _firestore = FirestoreService();

  Future<String> create(AnnouncementModel announcement) => _firestore.add(
      FirestoreCollections.announcements, announcement.toFirestore());

  Stream<List<AnnouncementModel>> announcements() {
    return _firestore
        .streamList(FirestoreCollections.announcements)
        .map((list) => list.map(AnnouncementModel.fromMap).toList());
  }

  Future<void> delete(String id) =>
      _firestore.deleteDoc(FirestoreCollections.announcements, id);
}
