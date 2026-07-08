import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:blood_beacon/app/config/app_constants.dart';
import 'package:blood_beacon/app/config/app_enums.dart';
import 'package:blood_beacon/app/services/location_service.dart';
import 'package:blood_beacon/app/utils/utils.dart';
import 'package:blood_beacon/data/model/place_model.dart';
import 'package:blood_beacon/data/repositories/hospital_repository.dart';

class MapTabController extends GetxController {
  final LocationService _location = Get.find<LocationService>();
  final HospitalRepository _hospitalRepo = HospitalRepository();

  final Rxn<LatLng> center = Rxn<LatLng>();
  final RxBool loading = false.obs;
  final Rx<PlaceType> placeType = PlaceType.hospital.obs;
  final RxList<PlaceModel> places = <PlaceModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    load(silent: true);
  }

  Future<void> load({bool silent = false}) async {
    try {
      loading.value = true;
      final pos = await _location.getCurrentPosition();
      if (pos == null) {
        if (!silent) Utils.showToast(message: 'Enable location to view the map');
        center.value ??= const LatLng(20.5937, 78.9629);
        return;
      }
      center.value = LatLng(pos.latitude, pos.longitude);
      final results = await _hospitalRepo.searchHybrid(
        latitude: pos.latitude,
        longitude: pos.longitude,
        radiusKm: AppConstants.defaultSearchRadiusKm,
        type: placeType.value,
      );
      places.assignAll(results);
    } catch (_) {
      if (!silent) Utils.showToast(message: 'Could not load map data');
    } finally {
      loading.value = false;
    }
  }

  void setType(PlaceType type) {
    placeType.value = type;
    load();
  }
}
