import 'package:blood_beacon/app/config/app_constants.dart';
import 'package:blood_beacon/data/model/favorite_model.dart';
import 'package:blood_beacon/data/provider/firebase/firestore_service.dart';

class FavoriteRepository {
  final FirestoreService _firestore = FirestoreService();

  Future<String> add(String userId, FavoriteModel favorite) =>
      _firestore.addToUserSub(
          userId, FirestoreCollections.favorites, favorite.toFirestore());

  Future<void> remove(String userId, String id) =>
      _firestore.deleteUserSub(userId, FirestoreCollections.favorites, id);

  Stream<List<FavoriteModel>> favorites(String userId) {
    return _firestore
        .streamUserSubList(userId, FirestoreCollections.favorites)
        .map((list) => list.map(FavoriteModel.fromMap).toList());
  }

  Future<List<FavoriteModel>> getFavorites(String userId) async {
    final list =
        await _firestore.getUserSubList(userId, FirestoreCollections.favorites);
    return list.map(FavoriteModel.fromMap).toList();
  }
}
