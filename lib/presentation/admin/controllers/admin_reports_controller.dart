import 'package:get/get.dart';
import 'package:blood_beacon/app/utils/utils.dart';
import 'package:blood_beacon/data/model/report_model.dart';
import 'package:blood_beacon/data/repositories/report_repository.dart';
import 'package:blood_beacon/data/repositories/user_repository.dart';

class AdminReportsController extends GetxController {
  final ReportRepository _repo = ReportRepository();
  final UserRepository _userRepository = UserRepository();

  Stream<List<ReportModel>> get reports => _repo.allReports();

  Future<void> ignore(String id) async {
    await _repo.updateStatus(id, 'ignored');
    Utils.showToast(message: 'Report ignored');
  }

  Future<void> review(String id) async {
    await _repo.updateStatus(id, 'reviewed');
    Utils.showToast(message: 'Marked as reviewed');
  }

  Future<void> takeAction(ReportModel report) async {
    if (report.id == null) return;
    await _repo.updateStatus(report.id!, 'actioned');
    if (report.reportedUserId != null) {
      await _userRepository.setDisabled(report.reportedUserId!, true);
    }
    Utils.showToast(message: 'User disabled and report actioned');
  }

  Future<void> delete(String id) async {
    await _repo.delete(id);
    Utils.showToast(message: 'Report deleted');
  }
}
