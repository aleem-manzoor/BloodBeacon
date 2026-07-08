class PlaceModel {
  final String? id;
  final String? name;
  final String? address;
  final String? city;
  final double? latitude;
  final double? longitude;
  final String? phone;
  final String? type;
  final bool verified;
  final double? distanceKm;

  PlaceModel({
    this.id,
    this.name,
    this.address,
    this.city,
    this.latitude,
    this.longitude,
    this.phone,
    this.type,
    this.verified = false,
    this.distanceKm,
  });

  factory PlaceModel.fromMap(Map<String, dynamic> map) {
    return PlaceModel(
      id: map['id'] as String?,
      name: map['name'] as String?,
      address: map['address'] as String?,
      city: map['city'] as String?,
      latitude: (map['latitude'] as num?)?.toDouble(),
      longitude: (map['longitude'] as num?)?.toDouble(),
      phone: map['phone'] as String?,
      type: map['type'] as String?,
      verified: map['verified'] as bool? ?? true,
    );
  }

  factory PlaceModel.fromOsm(Map<String, dynamic> element) {
    final tags = (element['tags'] as Map?)?.cast<String, dynamic>() ?? {};
    final lat = (element['lat'] ?? element['center']?['lat']) as num?;
    final lon = (element['lon'] ?? element['center']?['lon']) as num?;
    final street = [tags['addr:housenumber'], tags['addr:street'], tags['addr:city']]
        .where((e) => e != null && (e as String).isNotEmpty)
        .join(', ');
    return PlaceModel(
      id: element['id']?.toString(),
      name: tags['name'] as String? ?? 'Unnamed location',
      address: street.isEmpty ? null : street,
      latitude: lat?.toDouble(),
      longitude: lon?.toDouble(),
      phone: (tags['phone'] ?? tags['contact:phone']) as String?,
      type: tags['amenity'] == 'blood_bank' || tags['healthcare'] == 'blood_donation'
          ? 'Blood Bank'
          : 'Hospital',
      verified: false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'address': address,
      'city': city,
      'latitude': latitude,
      'longitude': longitude,
      'phone': phone,
      'type': type,
      'verified': verified,
    };
  }

  PlaceModel copyWith({double? distanceKm, bool? verified}) {
    return PlaceModel(
      id: id,
      name: name,
      address: address,
      city: city,
      latitude: latitude,
      longitude: longitude,
      phone: phone,
      type: type,
      verified: verified ?? this.verified,
      distanceKm: distanceKm ?? this.distanceKm,
    );
  }
}
