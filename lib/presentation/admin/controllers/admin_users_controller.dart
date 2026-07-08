import 'package:get/get.dart';
import 'package:blood_beacon/app/utils/utils.dart';
import 'package:blood_beacon/data/model/user_model.dart';
import 'package:blood_beacon/data/repositories/user_repository.dart';

class AdminUsersController extends GetxController {
  final UserRepository _repo = UserRepository();

  final RxList<UserModel> users = <UserModel>[].obs;
  final RxString query = ''.obs;
  final RxBool loading = false.obs;

  List<UserModel> get filtered {
    if (query.value.isEmpty) return users;
    final q = query.value.toLowerCase();
    return users
        .where((u) =>
            (u.fullName ?? '').toLowerCase().contains(q) ||
            (u.email ?? '').toLowerCase().contains(q))
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    try {
      loading.value = true;
      users.assignAll(await _repo.getAllUsers());
    } finally {
      loading.value = false;
    }
  }

  Future<void> toggleDisabled(UserModel user) async {
    if (user.uid == null) return;
    final newValue = !(user.isDisabled ?? false);
    await _repo.setDisabled(user.uid!, newValue);
    Utils.showToast(message: newValue ? 'User disabled' : 'User enabled');
    await load();
  }

  Future<void> deleteUser(String uid) async {
    await _repo.deleteUser(uid);
    Utils.showToast(message: 'User deleted');
    await load();
  }
}
