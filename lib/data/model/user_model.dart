import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'location_model.dart'; // Assuming this holds the LocationModel class

class AppUser {
  final String? id;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? address;
  final String? profilePicture;

  final List<DocumentReference>? locationRefs;
  final DocumentReference? activeLocationRef;

  // Optional: preload actual location data
  List<LocationModel>? locations;
  LocationModel? activeLocation;

  AppUser({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.address,
    this.profilePicture,
    this.locationRefs,
    this.activeLocationRef,
    this.locations,
    this.activeLocation,
  });

  factory AppUser.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    final List<DocumentReference> locationRefs =
        (data['locations'] as List<dynamic>?)?.cast<DocumentReference>() ?? [];

    final DocumentReference? activeLocationRef =
    data['activeLocation'] as DocumentReference?;

    return AppUser(
      id: doc.id,
      username: data['username'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      phone: data['phone'],
      address: data['address'],
      profilePicture: data['profilePicture'],
      email: data['email'],
      locationRefs: locationRefs,
      activeLocationRef: activeLocationRef,
    );
  }

  /// Call this to load actual location objects
  Future<void> fetchLocationData() async {
    if (locationRefs != null) {
      locations = await Future.wait(locationRefs!.map((ref) async {
        final snapshot = await ref.get();
        return snapshot.exists ? LocationModel.fromFirestore(snapshot) : null;
      }).where((loc) => loc != null)).then((list) => list.cast<LocationModel>());
    }

    if (activeLocationRef != null) {
      final snapshot = await activeLocationRef!.get();
      if (snapshot.exists) {
        activeLocation = LocationModel.fromFirestore(snapshot);
      }
    }
  }
}
