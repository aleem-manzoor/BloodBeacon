import 'package:blood_beacon/app/config/app_constants.dart';
import 'package:blood_beacon/data/model/donation_model.dart';
import 'package:blood_beacon/data/provider/firebase/firestore_service.dart';

class DonationRepository {
  final FirestoreService _firestore = FirestoreService();

  Future<String> add(String userId, DonationModel donation) =>
      _firestore.addToUserSub(
          userId, FirestoreCollections.donations, donation.toFirestore());

  Stream<List<DonationModel>> userDonations(String userId) {
    return _firestore
        .streamUserSubList(userId, FirestoreCollections.donations)
        .map((list) => list.map(DonationModel.fromMap).toList());
  }

  Future<List<DonationModel>> getUserDonations(String userId) async {
    final list =
        await _firestore.getUserSubList(userId, FirestoreCollections.donations);
    return list.map(DonationModel.fromMap).toList();
  }

  Future<void> delete(String userId, String id) =>
      _firestore.deleteUserSub(userId, FirestoreCollections.donations, id);
}
