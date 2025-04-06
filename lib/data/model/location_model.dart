import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../utils/app_logger.dart';
import 'user_model.dart';

class LocationModel {
  final String? id;
  final String? name;
  final LatLng? location;
  final List<DocumentReference>? memberRefs;
  List<AppUser>? members; // Populated manually after fetching

  LocationModel({
    this.id,
    this.name,
    this.location,
    this.memberRefs,
    this.members,
  });

  factory LocationModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    final geoPoint = data['location'] as GeoPoint?;
    final List<DocumentReference> refs =
        (data['members'] as List<dynamic>?)?.cast<DocumentReference>() ?? [];

    return LocationModel(
      id: doc.id,
      name: data['name'],
      location: geoPoint != null ? LatLng(geoPoint.latitude, geoPoint.longitude) : null,
      memberRefs: refs,
    );
  }

  /// Fetches user details from each DocumentReference in memberRefs
  Future<void> fetchMembers() async {
    if (memberRefs == null) return;

    List<AppUser> loadedUsers = [];

    for (final ref in memberRefs!) {
      final snapshot = await ref.get();
      if (snapshot.exists) {
        loadedUsers.add(AppUser.fromFirestore(snapshot));
      }
    }

    AppLogger.debug("Meme le :: ${loadedUsers.length??0}");

    members = loadedUsers;
  }

  @override
  String toString() {
    return 'LocationModel(id: $id, name: $name, members: ${members?.length ?? 0})';
  }
}
