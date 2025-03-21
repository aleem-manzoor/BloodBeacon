class UserModel {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? dateOfBirth;
  final String? email;
  final String? role;
  final String? access;
  final String? refresh;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.dateOfBirth,
    this.email,
    this.role,
    this.access,
    this.refresh,
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
}
