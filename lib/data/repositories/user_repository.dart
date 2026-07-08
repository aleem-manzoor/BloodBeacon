import 'package:blood_beacon/app/config/app_constants.dart';
import 'package:blood_beacon/data/model/user_model.dart';
import 'package:blood_beacon/data/provider/firebase/firestore_service.dart';

class UserRepository {
  final FirestoreService _firestore = FirestoreService();

  Future<void> createOrUpdateProfile(UserModel user) =>
      _firestore.saveUser(user.uid!, user.toFirestore());

  Future<UserModel?> getProfile(String uid) async {
    final data = await _firestore.getUser(uid);
    return data == null ? null : UserModel.fromMap(data);
  }

  Stream<UserModel?> profileStream(String uid) =>
      _firestore.userStream(uid).map((d) => d == null ? null : UserModel.fromMap(d));

  Future<void> updateFields(String uid, Map<String, dynamic> fields) =>
      _firestore.updateUser(uid, fields);

  Future<List<UserModel>> getAvailableDonors({String? bloodGroup}) async {
    final list = await _firestore.getList(
      FirestoreCollections.users,
      builder: (q) {
        var query = q
            .where('isDonor', isEqualTo: true)
            .where('isAvailable', isEqualTo: true)
            .where('isDisabled', isEqualTo: false);
        if (bloodGroup != null && bloodGroup.isNotEmpty) {
          query = query.where('bloodGroup', isEqualTo: bloodGroup);
        }
        return query;
      },
    );
    return list.map((e) => UserModel.fromMap({...e, 'uid': e['id']})).toList();
  }

  Future<List<UserModel>> getAllUsers() async {
    final list = await _firestore.getList(FirestoreCollections.users);
    return list.map((e) => UserModel.fromMap({...e, 'uid': e['id']})).toList();
  }

  Future<void> setDisabled(String uid, bool disabled) =>
      _firestore.updateUser(uid, {'isDisabled': disabled});

  Future<void> deleteUser(String uid) =>
      _firestore.deleteDoc(FirestoreCollections.users, uid);
}
