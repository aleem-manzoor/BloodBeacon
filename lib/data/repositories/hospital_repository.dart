import 'package:blood_beacon/app/config/app_constants.dart';
import 'package:blood_beacon/app/config/app_enums.dart';
import 'package:blood_beacon/app/services/osm_service.dart';
import 'package:blood_beacon/data/model/place_model.dart';
import 'package:blood_beacon/data/provider/firebase/firestore_service.dart';

class HospitalRepository {
  final FirestoreService _firestore = FirestoreService();
  final OsmService _osm = OsmService();

  String _collectionFor(PlaceType type) => type == PlaceType.hospital
      ? FirestoreCollections.hospitals
      : FirestoreCollections.bloodBanks;

  Future<List<PlaceModel>> getVerified(PlaceType type) async {
    final list = await _firestore.getList(_collectionFor(type));
    return list
        .map((e) => PlaceModel.fromMap(e).copyWith(verified: true))
        .toList();
  }

  Future<List<PlaceModel>> searchHybrid({
    required double latitude,
    required double longitude,
    required double radiusKm,
    required PlaceType type,
  }) async {
    List<PlaceModel> verified = [];
    List<PlaceModel> osmResults = [];
    try {
      verified = await getVerified(type);
    } catch (_) {}
    try {
      osmResults = await _osm.searchNearby(
        latitude: latitude,
        longitude: longitude,
        radiusKm: radiusKm,
        type: type,
      );
    } catch (_) {}
    return [...verified, ...osmResults];
  }

  Future<String> create(PlaceType type, PlaceModel place) =>
      _firestore.add(_collectionFor(type), place.toFirestore());

  Future<void> upsert(PlaceType type, String id, PlaceModel place) =>
      _firestore.setDoc(_collectionFor(type), id, place.toFirestore());

  Future<void> update(PlaceType type, String id, PlaceModel place) =>
      _firestore.updateDoc(_collectionFor(type), id, place.toFirestore());

  Future<void> setVerified(PlaceType type, String id, bool verified) =>
      _firestore.updateDoc(_collectionFor(type), id, {'verified': verified});

  Future<void> delete(PlaceType type, String id) =>
      _firestore.deleteDoc(_collectionFor(type), id);

  Stream<List<PlaceModel>> streamVerified(PlaceType type) {
    return _firestore.streamList(_collectionFor(type)).map(
          (list) =>
              list.map((e) => PlaceModel.fromMap(e).copyWith(verified: true)).toList(),
        );
  }
}
