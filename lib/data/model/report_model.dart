class ReportModel {
  final String? id;
  final String? reportedUserId;
  final String? reportedUserName;
  final String? reason;
  final String? details;
  final String? status;
  final String? reportedBy;
  final String? createdAt;

  ReportModel({
    this.id,
    this.reportedUserId,
    this.reportedUserName,
    this.reason,
    this.details,
    this.status,
    this.reportedBy,
    this.createdAt,
  });

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel(
      id: map['id'] as String?,
      reportedUserId: map['reportedUserId'] as String?,
      reportedUserName: map['reportedUserName'] as String?,
      reason: map['reason'] as String?,
      details: map['details'] as String?,
      status: map['status'] as String?,
      reportedBy: map['reportedBy'] as String?,
      createdAt: map['createdAt'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'reportedUserId': reportedUserId,
      'reportedUserName': reportedUserName,
      'reason': reason,
      'details': details,
      'status': status ?? 'pending',
      'reportedBy': reportedBy,
      'createdAt': createdAt,
    };
  }
}
