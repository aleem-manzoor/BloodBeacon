import 'package:blood_beacon/app/config/app_constants.dart';
import 'package:blood_beacon/data/model/blood_request_model.dart';
import 'package:blood_beacon/data/provider/firebase/firestore_service.dart';

class BloodRequestRepository {
  final FirestoreService _firestore = FirestoreService();

  Future<String> create(BloodRequestModel request) =>
      _firestore.add(FirestoreCollections.bloodRequests, request.toFirestore());

  Stream<List<BloodRequestModel>> myRequests(String userId) {
    return _firestore
        .streamList(
          FirestoreCollections.bloodRequests,
          builder: (q) => q.where('createdBy', isEqualTo: userId),
        )
        .map((list) => list.map(BloodRequestModel.fromMap).toList());
  }

  Stream<List<BloodRequestModel>> activeRequests() {
    return _firestore
        .streamList(
          FirestoreCollections.bloodRequests,
          builder: (q) => q
              .where('status', isEqualTo: 'pending')
              .where('moderationStatus', isEqualTo: 'approved'),
        )
        .map((list) => list.map(BloodRequestModel.fromMap).toList());
  }

  Stream<List<BloodRequestModel>> allRequests() {
    return _firestore
        .streamList(FirestoreCollections.bloodRequests)
        .map((list) => list.map(BloodRequestModel.fromMap).toList());
  }

  Future<void> updateStatus(String id, String status) =>
      _firestore.updateDoc(FirestoreCollections.bloodRequests, id, {'status': status});

  Future<void> updateModeration(String id, String moderationStatus) =>
      _firestore.updateDoc(FirestoreCollections.bloodRequests, id,
          {'moderationStatus': moderationStatus});

  Future<void> delete(String id) =>
      _firestore.deleteDoc(FirestoreCollections.bloodRequests, id);
}
