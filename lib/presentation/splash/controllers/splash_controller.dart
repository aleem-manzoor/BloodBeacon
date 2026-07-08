import 'package:get/get.dart';
import 'package:blood_beacon/app/routes/app_pages.dart';
import 'package:blood_beacon/app/services/session_service.dart';
import 'package:blood_beacon/data/provider/firebase/firebase_auth_service.dart';

class SplashController extends GetxController {
  final FirebaseAuthService _authService = FirebaseAuthService();

  @override
  void onInit() {
    super.onInit();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    await Future.delayed(const Duration(seconds: 2));
    final user = _authService.currentUser;
    if (user == null) {
      Get.offAllNamed(Routes.LOGIN);
      return;
    }
    final profile = await Get.find<SessionService>().load(user.uid);
    if (profile == null || profile.isDisabled == true) {
      await _authService.logout();
      Get.offAllNamed(Routes.LOGIN);
      return;
    }
    Get.offAllNamed(profile.isAdmin ? Routes.ADMIN : Routes.MAIN);
  }
}
