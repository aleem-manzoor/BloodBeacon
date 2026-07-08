import 'dart:async';

import 'package:get/get.dart';
import 'package:blood_beacon/app/config/global_var.dart';
import 'package:blood_beacon/data/model/user_model.dart';
import 'package:blood_beacon/data/provider/firebase/firebase_auth_service.dart';
import 'package:blood_beacon/data/provider/firebase/push_notification_service.dart';
import 'package:blood_beacon/data/provider/local_storage/local_db.dart';
import 'package:blood_beacon/data/repositories/user_repository.dart';

class SessionService extends GetxService {
  final UserRepository _userRepository = UserRepository();
  final FirebaseAuthService _authService = FirebaseAuthService();

  final Rxn<UserModel> user = Rxn<UserModel>();
  StreamSubscription? _sub;

  bool get isLoggedIn => user.value != null;
  bool get isAdmin => user.value?.role == 'admin';
  bool get isDonor => user.value?.isDonor == true;

  Future<UserModel?> load(String uid) async {
    final profile = await _userRepository.getProfile(uid);
    user.value = profile;
    if (profile != null) {
      Globals.userId = profile.uid ?? uid;
      Globals.email = profile.email;
      Globals.fullName = profile.fullName ?? '';
      if (Get.isRegistered<PushNotificationService>()) {
        Get.find<PushNotificationService>().registerToken(uid);
      }
    }
    _listen(uid);
    return profile;
  }

  void _listen(String uid) {
    _sub?.cancel();
    _sub = _userRepository.profileStream(uid).listen((u) {
      if (u != null) user.value = u;
    });
  }

  Future<void> signOut() async {
    await _authService.logout();
    LocalDB.clear();
    Globals.authToken = '';
    Globals.userId = '';
    Globals.email = null;
    Globals.fullName = '';
    clear();
  }

  void clear() {
    _sub?.cancel();
    user.value = null;
  }

  @override
  void onClose() {
    _sub?.cancel();
    super.onClose();
  }
}
