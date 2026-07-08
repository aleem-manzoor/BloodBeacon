import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blood_beacon/app/config/app_constants.dart';

typedef FirestoreQuery = Query<Map<String, dynamic>> Function(
    Query<Map<String, dynamic>> query);

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> collection(String name) =>
      _db.collection(name);

  DocumentReference<Map<String, dynamic>> userDoc(String uid) =>
      collection(FirestoreCollections.users).doc(uid);

  CollectionReference<Map<String, dynamic>> userSub(String uid, String sub) =>
      userDoc(uid).collection(sub);

  Future<void> saveUser(String uid, Map<String, dynamic> data) =>
      userDoc(uid).set(data, SetOptions(merge: true));

  Future<Map<String, dynamic>?> getUser(String uid) async {
    final snap = await userDoc(uid).get();
    if (!snap.exists) return null;
    return {...snap.data()!, 'uid': snap.id};
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) =>
      userDoc(uid).update(data);

  Stream<Map<String, dynamic>?> userStream(String uid) =>
      userDoc(uid).snapshots().map(
            (s) => s.exists ? {...s.data()!, 'uid': s.id} : null,
          );

  Future<String> add(String name, Map<String, dynamic> data) async {
    final ref = await collection(name).add(data);
    return ref.id;
  }

  Future<void> setDoc(String name, String id, Map<String, dynamic> data,
          {bool merge = true}) =>
      collection(name).doc(id).set(data, SetOptions(merge: merge));

  Future<void> updateDoc(String name, String id, Map<String, dynamic> data) =>
      collection(name).doc(id).update(data);

  Future<void> deleteDoc(String name, String id) =>
      collection(name).doc(id).delete();

  Future<Map<String, dynamic>?> getById(String name, String id) async {
    final snap = await collection(name).doc(id).get();
    if (!snap.exists) return null;
    return {...snap.data()!, 'id': snap.id};
  }

  Future<List<Map<String, dynamic>>> getList(String name,
      {FirestoreQuery? builder}) async {
    Query<Map<String, dynamic>> query = collection(name);
    if (builder != null) query = builder(query);
    final snap = await query.get();
    return snap.docs.map((d) => {...d.data(), 'id': d.id}).toList();
  }

  Stream<List<Map<String, dynamic>>> streamList(String name,
      {FirestoreQuery? builder}) {
    Query<Map<String, dynamic>> query = collection(name);
    if (builder != null) query = builder(query);
    return query.snapshots().map(
          (snap) => snap.docs.map((d) => {...d.data(), 'id': d.id}).toList(),
        );
  }

  Future<String> addToUserSub(
      String uid, String sub, Map<String, dynamic> data) async {
    final ref = await userSub(uid, sub).add(data);
    return ref.id;
  }

  Future<List<Map<String, dynamic>>> getUserSubList(String uid, String sub,
      {FirestoreQuery? builder}) async {
    Query<Map<String, dynamic>> query = userSub(uid, sub);
    if (builder != null) query = builder(query);
    final snap = await query.get();
    return snap.docs.map((d) => {...d.data(), 'id': d.id}).toList();
  }

  Stream<List<Map<String, dynamic>>> streamUserSubList(String uid, String sub,
      {FirestoreQuery? builder}) {
    Query<Map<String, dynamic>> query = userSub(uid, sub);
    if (builder != null) query = builder(query);
    return query.snapshots().map(
          (snap) => snap.docs.map((d) => {...d.data(), 'id': d.id}).toList(),
        );
  }

  Future<void> deleteUserSub(String uid, String sub, String id) =>
      userSub(uid, sub).doc(id).delete();

  Future<int> count(String name, {FirestoreQuery? builder}) async {
    Query<Map<String, dynamic>> query = collection(name);
    if (builder != null) query = builder(query);
    final snap = await query.count().get();
    return snap.count ?? 0;
  }

  Future<int> countGroup(String sub) async {
    final snap = await _db.collectionGroup(sub).count().get();
    return snap.count ?? 0;
  }
}
