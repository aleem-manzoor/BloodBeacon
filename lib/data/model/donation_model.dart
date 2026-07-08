class DonationModel {
  final String? id;
  final String? date;
  final String? hospital;
  final String? bloodGroup;
  final int? units;
  final String? requestId;
  final String? userId;

  DonationModel({
    this.id,
    this.date,
    this.hospital,
    this.bloodGroup,
    this.units,
    this.requestId,
    this.userId,
  });

  factory DonationModel.fromMap(Map<String, dynamic> map) {
    return DonationModel(
      id: map['id'] as String?,
      date: map['date'] as String?,
      hospital: map['hospital'] as String?,
      bloodGroup: map['bloodGroup'] as String?,
      units: (map['units'] as num?)?.toInt(),
      requestId: map['requestId'] as String?,
      userId: map['userId'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'date': date,
      'hospital': hospital,
      'bloodGroup': bloodGroup,
      'units': units,
      'requestId': requestId,
      'userId': userId,
    };
  }
}
