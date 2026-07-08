import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:blood_beacon/app/config/app_enums.dart';
import 'package:blood_beacon/data/model/place_model.dart';

class OsmService extends GetxService {
  static const List<String> _endpoints = [
    'https://overpass-api.de/api/interpreter',
    'https://overpass.kumi.systems/api/interpreter',
  ];

  Future<List<PlaceModel>> searchNearby({
    required double latitude,
    required double longitude,
    required double radiusKm,
    required PlaceType type,
  }) async {
    final radius = (radiusKm * 1000).round();
    final filters = type == PlaceType.hospital
        ? '''
node["amenity"="hospital"](around:$radius,$latitude,$longitude);
way["amenity"="hospital"](around:$radius,$latitude,$longitude);
'''
        : '''
node["amenity"="blood_bank"](around:$radius,$latitude,$longitude);
way["amenity"="blood_bank"](around:$radius,$latitude,$longitude);
node["healthcare"="blood_donation"](around:$radius,$latitude,$longitude);
way["healthcare"="blood_donation"](around:$radius,$latitude,$longitude);
''';

    final query = '[out:json][timeout:25];($filters);out center 50;';

    Object? lastError;
    for (final endpoint in _endpoints) {
      try {
        final response = await http
            .post(
              Uri.parse(endpoint),
              headers: const {'User-Agent': 'BloodBeacon/1.0 (blood donation app)'},
              body: {'data': query},
            )
            .timeout(const Duration(seconds: 30));

        if (response.statusCode != 200) {
          lastError = 'HTTP ${response.statusCode}';
          continue;
        }

        final decoded = jsonDecode(response.body) as Map<String, dynamic>;
        final elements = (decoded['elements'] as List?) ?? [];
        return elements
            .map((e) => PlaceModel.fromOsm((e as Map).cast<String, dynamic>()))
            .where((p) => p.latitude != null && p.longitude != null)
            .toList();
      } catch (e) {
        lastError = e;
      }
    }
    throw Exception('OpenStreetMap request failed: $lastError');
  }
}
