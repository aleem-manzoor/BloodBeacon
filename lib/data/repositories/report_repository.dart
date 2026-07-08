import 'package:blood_beacon/app/config/app_constants.dart';
import 'package:blood_beacon/data/model/report_model.dart';
import 'package:blood_beacon/data/provider/firebase/firestore_service.dart';

class ReportRepository {
  final FirestoreService _firestore = FirestoreService();

  Future<String> create(ReportModel report) =>
      _firestore.add(FirestoreCollections.reports, report.toFirestore());

  Stream<List<ReportModel>> allReports() {
    return _firestore
        .streamList(FirestoreCollections.reports)
        .map((list) => list.map(ReportModel.fromMap).toList());
  }

  Future<void> updateStatus(String id, String status) =>
      _firestore.updateDoc(FirestoreCollections.reports, id, {'status': status});

  Future<void> delete(String id) =>
      _firestore.deleteDoc(FirestoreCollections.reports, id);
}
