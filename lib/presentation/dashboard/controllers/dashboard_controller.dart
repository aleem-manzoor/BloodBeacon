import 'package:get/get.dart';
import 'package:blood_beacon/app/routes/app_pages.dart';
import 'package:blood_beacon/app/services/session_service.dart';
import 'package:blood_beacon/data/model/announcement_model.dart';
import 'package:blood_beacon/data/model/blood_request_model.dart';
import 'package:blood_beacon/data/model/donation_model.dart';
import 'package:blood_beacon/data/repositories/announcement_repository.dart';
import 'package:blood_beacon/data/repositories/blood_request_repository.dart';
import 'package:blood_beacon/data/repositories/donation_repository.dart';
import 'package:blood_beacon/data/repositories/favorite_repository.dart';
import 'package:blood_beacon/presentation/main/controllers/main_controller.dart';

class DashboardController extends GetxController {
  final SessionService session = Get.find<SessionService>();
  final BloodRequestRepository _requestRepo = BloodRequestRepository();
  final AnnouncementRepository _announcementRepo = AnnouncementRepository();
  final DonationRepository _donationRepo = DonationRepository();
  final FavoriteRepository _favoriteRepo = FavoriteRepository();

  final RxInt donationCount = 0.obs;
  final RxInt myRequestCount = 0.obs;
  final RxInt favoriteCount = 0.obs;

  String get uid => session.user.value?.uid ?? '';

  Stream<List<BloodRequestModel>> get activeRequests =>
      _requestRepo.activeRequests();

  Stream<List<AnnouncementModel>> get announcements =>
      _announcementRepo.announcements();

  Stream<List<DonationModel>> get donations => _donationRepo.userDonations(uid);

  @override
  void onInit() {
    super.onInit();
    _loadCounts();
  }

  Future<void> _loadCounts() async {
    if (uid.isEmpty) return;
    final donationsList = await _donationRepo.getUserDonations(uid);
    donationCount.value = donationsList.length;
    final favs = await _favoriteRepo.getFavorites(uid);
    favoriteCount.value = favs.length;
    _requestRepo.myRequests(uid).listen((list) {
      myRequestCount.value = list.length;
    });
  }

  void goCreateRequest() => Get.toNamed(Routes.CREATE_REQUEST);
  void goHospitals() => Get.toNamed(Routes.HOSPITALS);
  void goDonations() => Get.toNamed(Routes.DONATION_HISTORY);
  void goNotifications() => Get.toNamed(Routes.NOTIFICATIONS);
  void goFavorites() => Get.toNamed(Routes.FAVORITES);
  void becomeDonor() => Get.toNamed(Routes.BECOME_DONOR);

  void switchTab(int index) => Get.find<MainController>().changeTab(index);
}
