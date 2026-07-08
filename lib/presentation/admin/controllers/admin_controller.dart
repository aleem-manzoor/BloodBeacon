import 'package:get/get.dart';
import 'package:blood_beacon/app/config/app_constants.dart';
import 'package:blood_beacon/app/routes/app_pages.dart';
import 'package:blood_beacon/app/services/session_service.dart';
import 'package:blood_beacon/data/provider/firebase/firestore_service.dart';

class AdminController extends GetxController {
  final FirestoreService _firestore = FirestoreService();
  final SessionService session = Get.find<SessionService>();

  final RxMap<String, int> stats = <String, int>{}.obs;
  final RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadStats();
  }

  Future<void> loadStats() async {
    try {
      loading.value = true;
      final results = await Future.wait([
        _firestore.count(FirestoreCollections.users),
        _firestore.count(FirestoreCollections.users,
            builder: (q) => q.where('isDonor', isEqualTo: true)),
        _firestore.count(FirestoreCollections.users,
            builder: (q) => q
                .where('isDonor', isEqualTo: true)
                .where('isAvailable', isEqualTo: true)),
        _firestore.count(FirestoreCollections.bloodRequests,
            builder: (q) => q.where('status', isEqualTo: 'pending')),
        _firestore.countGroup(FirestoreCollections.donations),
        _firestore.count(FirestoreCollections.hospitals,
            builder: (q) => q.where('verified', isEqualTo: true)),
        _firestore.count(FirestoreCollections.bloodBanks,
            builder: (q) => q.where('verified', isEqualTo: true)),
      ]);
      stats.assignAll({
        'Total Users': results[0],
        'Total Donors': results[1],
        'Available Donors': results[2],
        'Active Requests': results[3],
        'Donations': results[4],
        'Verified Hospitals': results[5],
        'Verified Blood Banks': results[6],
      });
    } catch (_) {
      // counts unavailable
    } finally {
      loading.value = false;
    }
  }

  void goUsers() => Get.toNamed(Routes.ADMIN_USERS);
  void goRequests() => Get.toNamed(Routes.ADMIN_REQUESTS);
  void goHospitals() => Get.toNamed(Routes.ADMIN_HOSPITALS);
  void goReports() => Get.toNamed(Routes.ADMIN_REPORTS);
  void goAnnouncements() => Get.toNamed(Routes.ADMIN_ANNOUNCEMENTS);

  Future<void> logout() async {
    await session.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
