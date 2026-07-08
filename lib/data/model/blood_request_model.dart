class BloodRequestModel {
  final String? id;
  final String? patientName;
  final String? bloodGroup;
  final int? units;
  final String? hospitalName;
  final String? hospitalAddress;
  final String? notes;
  final double? latitude;
  final double? longitude;
  final String? status;
  final String? moderationStatus;
  final String? createdBy;
  final String? createdByName;
  final String? creatorPhone;
  final String? createdAt;

  BloodRequestModel({
    this.id,
    this.patientName,
    this.bloodGroup,
    this.units,
    this.hospitalName,
    this.hospitalAddress,
    this.notes,
    this.latitude,
    this.longitude,
    this.status,
    this.moderationStatus,
    this.createdBy,
    this.createdByName,
    this.creatorPhone,
    this.createdAt,
  });

  factory BloodRequestModel.fromMap(Map<String, dynamic> map) {
    return BloodRequestModel(
      id: map['id'] as String?,
      patientName: map['patientName'] as String?,
      bloodGroup: map['bloodGroup'] as String?,
      units: (map['units'] as num?)?.toInt(),
      hospitalName: map['hospitalName'] as String?,
      hospitalAddress: map['hospitalAddress'] as String?,
      notes: map['notes'] as String?,
      latitude: (map['latitude'] as num?)?.toDouble(),
      longitude: (map['longitude'] as num?)?.toDouble(),
      status: map['status'] as String?,
      moderationStatus: map['moderationStatus'] as String?,
      createdBy: map['createdBy'] as String?,
      createdByName: map['createdByName'] as String?,
      creatorPhone: map['creatorPhone'] as String?,
      createdAt: map['createdAt'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'patientName': patientName,
      'bloodGroup': bloodGroup,
      'units': units,
      'hospitalName': hospitalName,
      'hospitalAddress': hospitalAddress,
      'notes': notes,
      'latitude': latitude,
      'longitude': longitude,
      'status': status ?? 'pending',
      'moderationStatus': moderationStatus ?? 'pending',
      'createdBy': createdBy,
      'createdByName': createdByName,
      'creatorPhone': creatorPhone,
      'createdAt': createdAt,
    };
  }
}
