import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:blood_beacon/app/config/app_constants.dart';
import 'package:blood_beacon/app/config/global_var.dart';
import 'package:blood_beacon/app/services/location_service.dart';
import 'package:blood_beacon/app/utils/utils.dart';
import 'package:blood_beacon/data/model/user_model.dart';
import 'package:blood_beacon/data/repositories/user_repository.dart';

class DonorSearchController extends GetxController {
  final LocationService _location = Get.find<LocationService>();
  final UserRepository _userRepository = UserRepository();

  final RxBool loading = false.obs;
  final RxString selectedBloodGroup = 'All'.obs;
  final RxDouble radiusKm = AppConstants.defaultSearchRadiusKm.obs;
  final RxList<UserModel> donors = <UserModel>[].obs;
  final RxnDouble myLat = RxnDouble();
  final RxnDouble myLng = RxnDouble();
  final Map<String, double> _distances = {};

  List<String> get bloodFilters => ['All', ...AppConstants.bloodGroups];

  @override
  void onInit() {
    super.onInit();
    search(silent: true);
  }

  Future<void> search({bool silent = false}) async {
    try {
      loading.value = true;
      final pos = await _location.getCurrentPosition();
      if (pos != null) {
        myLat.value = pos.latitude;
        myLng.value = pos.longitude;
      }

      final group = selectedBloodGroup.value == 'All'
          ? null
          : selectedBloodGroup.value;
      final list = await _userRepository.getAvailableDonors(bloodGroup: group);

      _distances.clear();
      final filtered = <UserModel>[];
      for (final d in list) {
        if (d.uid != null && d.uid == Globals.userId) continue;
        if (myLat.value != null &&
            d.latitude != null &&
            d.longitude != null) {
          final dist = _location.distanceKm(
              myLat.value!, myLng.value!, d.latitude!, d.longitude!);
          if (dist <= radiusKm.value) {
            if (d.uid != null) _distances[d.uid!] = dist;
            filtered.add(d);
          }
        } else {
          filtered.add(d);
        }
      }
      filtered.sort((a, b) => (_distances[a.uid] ?? 1e9)
          .compareTo(_distances[b.uid] ?? 1e9));
      donors.assignAll(filtered);
    } catch (_) {
      if (!silent) Utils.showToast(message: 'Could not load donors');
    } finally {
      loading.value = false;
    }
  }

  void setBloodGroup(String group) {
    selectedBloodGroup.value = group;
    search();
  }

  void setRadius(double value) => radiusKm.value = value;

  Future<void> callDonor(String? phone) async {
    if (phone == null || phone.isEmpty) {
      Utils.showToast(message: 'No phone number available');
      return;
    }
    final uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Utils.showToast(message: 'Could not start a call');
    }
  }

  double? distanceFor(UserModel donor) =>
      donor.uid == null ? null : _distances[donor.uid];
}
