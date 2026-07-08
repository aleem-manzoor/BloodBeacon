class FavoriteModel {
  final String? id;
  final String? placeId;
  final String? name;
  final String? address;
  final double? latitude;
  final double? longitude;
  final String? phone;
  final String? placeType;
  final bool verified;
  final String? userId;
  final String? createdAt;

  FavoriteModel({
    this.id,
    this.placeId,
    this.name,
    this.address,
    this.latitude,
    this.longitude,
    this.phone,
    this.placeType,
    this.verified = false,
    this.userId,
    this.createdAt,
  });

  factory FavoriteModel.fromMap(Map<String, dynamic> map) {
    return FavoriteModel(
      id: map['id'] as String?,
      placeId: map['placeId'] as String?,
      name: map['name'] as String?,
      address: map['address'] as String?,
      latitude: (map['latitude'] as num?)?.toDouble(),
      longitude: (map['longitude'] as num?)?.toDouble(),
      phone: map['phone'] as String?,
      placeType: map['placeType'] as String?,
      verified: map['verified'] as bool? ?? false,
      userId: map['userId'] as String?,
      createdAt: map['createdAt'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'placeId': placeId,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'phone': phone,
      'placeType': placeType,
      'verified': verified,
      'userId': userId,
      'createdAt': createdAt,
    };
  }
}
