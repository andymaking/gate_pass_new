import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateUserLocation(String userId, double latitude, double longitude) async {
    await _firestore.collection('locations').doc(userId).set({
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getUserLocations() {
    return _firestore.collection('locations').snapshots();
  }
}
