import 'package:get/get.dart';
import 'package:blood_beacon/app/services/session_service.dart';
import 'package:blood_beacon/app/utils/utils.dart';
import 'package:blood_beacon/data/model/favorite_model.dart';
import 'package:blood_beacon/data/model/place_model.dart';
import 'package:blood_beacon/data/repositories/favorite_repository.dart';

class FavoritesController extends GetxController {
  final SessionService session = Get.find<SessionService>();
  final FavoriteRepository _repo = FavoriteRepository();

  String get uid => session.user.value?.uid ?? '';

  Stream<List<FavoriteModel>> get favorites => _repo.favorites(uid);

  Future<void> remove(String id) async {
    try {
      await _repo.remove(uid, id);
      Utils.showToast(message: 'Removed from favorites');
    } catch (_) {
      Utils.showToast(message: 'Could not remove favorite');
    }
  }

  PlaceModel toPlace(FavoriteModel f) => PlaceModel(
        id: f.placeId,
        name: f.name,
        address: f.address,
        latitude: f.latitude,
        longitude: f.longitude,
        phone: f.phone,
        type: f.placeType,
        verified: f.verified,
      );
}
