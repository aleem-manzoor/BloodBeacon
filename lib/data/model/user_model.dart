class UserModel {
  final int? id;
  final String? uid;
  final String? firstName;
  final String? lastName;
  final String? fullName;
  final String? phoneNumber;
  final String? dateOfBirth;
  final String? email;
  final String? role;
  final String? access;
  final String? refresh;
  final String? profilePicture;
  final String? bloodGroup;
  final int? age;
  final String? gender;
  final String? city;
  final double? latitude;
  final double? longitude;
  final String? lastDonationDate;
  final bool? isAvailable;
  final String? medicalEligibility;
  final bool? isDonor;
  final bool? isDisabled;
  final String? fcmToken;
  final String? createdAt;

  UserModel({
    this.id,
    this.uid,
    this.firstName,
    this.lastName,
    this.fullName,
    this.phoneNumber,
    this.dateOfBirth,
    this.email,
    this.role,
    this.access,
    this.refresh,
    this.profilePicture,
    this.bloodGroup,
    this.age,
    this.gender,
    this.city,
    this.latitude,
    this.longitude,
    this.lastDonationDate,
    this.isAvailable,
    this.medicalEligibility,
    this.isDonor,
    this.isDisabled,
    this.fcmToken,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      email: json['email'] as String?,
      role: json['role'] as String?,
      access: json['access'] as String?,
      refresh: json['refresh'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'date_of_birth': dateOfBirth,
      'email': email,
      'role': role,
      'access': access,
      'refresh': refresh,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String?,
      fullName: map['fullName'] as String?,
      email: map['email'] as String?,
      phoneNumber: map['phoneNumber'] as String?,
      profilePicture: map['profilePicture'] as String?,
      bloodGroup: map['bloodGroup'] as String?,
      age: (map['age'] as num?)?.toInt(),
      gender: map['gender'] as String?,
      city: map['city'] as String?,
      latitude: (map['latitude'] as num?)?.toDouble(),
      longitude: (map['longitude'] as num?)?.toDouble(),
      lastDonationDate: map['lastDonationDate'] as String?,
      isAvailable: map['isAvailable'] as bool?,
      medicalEligibility: map['medicalEligibility'] as String?,
      isDonor: map['isDonor'] as bool?,
      isDisabled: map['isDisabled'] as bool?,
      role: map['role'] as String?,
      fcmToken: map['fcmToken'] as String?,
      createdAt: map['createdAt'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'bloodGroup': bloodGroup,
      'age': age,
      'gender': gender,
      'city': city,
      'latitude': latitude,
      'longitude': longitude,
      'lastDonationDate': lastDonationDate,
      'isAvailable': isAvailable ?? false,
      'medicalEligibility': medicalEligibility,
      'isDonor': isDonor ?? false,
      'isDisabled': isDisabled ?? false,
      'role': role ?? 'user',
      'fcmToken': fcmToken,
      'createdAt': createdAt,
    };
  }

  UserModel copyWith({
    String? uid,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? profilePicture,
    String? bloodGroup,
    int? age,
    String? gender,
    String? city,
    double? latitude,
    double? longitude,
    String? lastDonationDate,
    bool? isAvailable,
    String? medicalEligibility,
    bool? isDonor,
    bool? isDisabled,
    String? role,
    String? fcmToken,
    String? createdAt,
  }) {
    return UserModel(
      id: id,
      uid: uid ?? this.uid,
      firstName: firstName,
      lastName: lastName,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth,
      profilePicture: profilePicture ?? this.profilePicture,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      city: city ?? this.city,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      lastDonationDate: lastDonationDate ?? this.lastDonationDate,
      isAvailable: isAvailable ?? this.isAvailable,
      medicalEligibility: medicalEligibility ?? this.medicalEligibility,
      isDonor: isDonor ?? this.isDonor,
      isDisabled: isDisabled ?? this.isDisabled,
      role: role ?? this.role,
      access: access,
      refresh: refresh,
      fcmToken: fcmToken ?? this.fcmToken,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  bool get isAdmin => role == 'admin';
}
