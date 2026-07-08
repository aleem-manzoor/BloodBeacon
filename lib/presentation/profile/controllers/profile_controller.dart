import 'package:get/get.dart';
import 'package:blood_beacon/app/routes/app_pages.dart';
import 'package:blood_beacon/app/services/session_service.dart';
import 'package:blood_beacon/app/utils/utils.dart';
import 'package:blood_beacon/data/model/user_model.dart';
import 'package:blood_beacon/data/repositories/user_repository.dart';

class ProfileController extends GetxController {
  final SessionService session = Get.find<SessionService>();
  final UserRepository _userRepository = UserRepository();

  final RxBool updatingAvailability = false.obs;

  UserModel? get user => session.user.value;

  Future<void> toggleAvailability(bool value) async {
    final uid = user?.uid;
    if (uid == null) return;
    try {
      updatingAvailability.value = true;
      await _userRepository.updateFields(uid, {'isAvailable': value});
      Utils.showToast(
          message: value ? 'You are now available' : 'You are now unavailable');
    } catch (_) {
      Utils.showToast(message: 'Could not update availability');
    } finally {
      updatingAvailability.value = false;
    }
  }

  void editProfile() => Get.toNamed(Routes.EDIT_PROFILE);
  void becomeDonor() => Get.toNamed(Routes.BECOME_DONOR);
  void openDonationHistory() => Get.toNamed(Routes.DONATION_HISTORY);
  void openFavorites() => Get.toNamed(Routes.FAVORITES);
  void openNotifications() => Get.toNamed(Routes.NOTIFICATIONS);

  Future<void> logout() async {
    await session.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
