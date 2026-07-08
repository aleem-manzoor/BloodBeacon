import 'package:get/get.dart';
import 'package:blood_beacon/app/config/app_constants.dart';
import 'package:blood_beacon/app/config/app_enums.dart';
import 'package:blood_beacon/app/services/location_service.dart';
import 'package:blood_beacon/app/services/session_service.dart';
import 'package:blood_beacon/app/utils/utils.dart';
import 'package:blood_beacon/data/model/favorite_model.dart';
import 'package:blood_beacon/data/model/place_model.dart';
import 'package:blood_beacon/data/repositories/favorite_repository.dart';
import 'package:blood_beacon/data/repositories/hospital_repository.dart';

class HospitalsController extends GetxController {
  final LocationService _location = Get.find<LocationService>();
  final HospitalRepository _hospitalRepo = HospitalRepository();
  final FavoriteRepository _favoriteRepo = FavoriteRepository();
  final SessionService session = Get.find<SessionService>();

  final RxBool loading = false.obs;
  final Rx<PlaceType> type = PlaceType.hospital.obs;
  final RxList<PlaceModel> places = <PlaceModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    try {
      loading.value = true;
      final pos = await _location.getCurrentPosition();
      final results = pos == null
          ? await _hospitalRepo.getVerified(type.value)
          : await _hospitalRepo.searchHybrid(
              latitude: pos.latitude,
              longitude: pos.longitude,
              radiusKm: AppConstants.defaultSearchRadiusKm,
              type: type.value,
            );
      final mapped = results.map((p) {
        if (pos != null && p.latitude != null && p.longitude != null) {
          final dist = _location.distanceKm(
              pos.latitude, pos.longitude, p.latitude!, p.longitude!);
          return p.copyWith(distanceKm: dist);
        }
        return p;
      }).toList()
        ..sort((a, b) =>
            (a.distanceKm ?? 1e9).compareTo(b.distanceKm ?? 1e9));
      places.assignAll(mapped);
    } catch (_) {
      Utils.showToast(message: 'Could not load nearby places');
    } finally {
      loading.value = false;
    }
  }

  void setType(PlaceType value) {
    type.value = value;
    load();
  }

  Future<void> saveFavorite(PlaceModel place) async {
    final uid = session.user.value?.uid;
    if (uid == null) return;
    try {
      await _favoriteRepo.add(
        uid,
        FavoriteModel(
          placeId: place.id,
          name: place.name,
          address: place.address,
          latitude: place.latitude,
          longitude: place.longitude,
          phone: place.phone,
          placeType: place.type,
          verified: place.verified,
          userId: uid,
          createdAt: DateTime.now().toIso8601String(),
        ),
      );
      Utils.showToast(message: 'Saved to favorites');
    } catch (_) {
      Utils.showToast(message: 'Could not save favorite');
    }
  }
}
