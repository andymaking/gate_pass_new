import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gate_pass/data/cache/constants.dart';
import 'package:gate_pass/utils/app_logger.dart';
import 'package:gate_pass/utils/string-extensions.dart';

import '../../model/vistor_pass_model.dart';

class LocationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Add user to a location and update user's location list
  Future<void> joinLocation({
    required String userId,
    required String locationId,
  }) async {
    final userRef = _firestore.collection('new_user').doc(userId);
    final locationRef = _firestore.collection('locations').doc(locationId);

    await _firestore.runTransaction((transaction) async {
      // 🔹 Read both user and location docs first (required by Firestore)
      final userSnap = await transaction.get(userRef);
      final locationSnap = await transaction.get(locationRef);

      final userData = userSnap.data() ?? {};
      final locationData = locationSnap.data() ?? {};

      final List<DocumentReference> currentLocations = List<DocumentReference>.from(
        userData['locations'] ?? [],
      );

      final List<DocumentReference> members = List<DocumentReference>.from(
        locationData['members'] ?? [],
      );

      final DocumentReference? activeLocation =
      userData['activeLocation'] != null
          ? userData['activeLocation'] as DocumentReference
          : null;

      // 🔸 Add location to user's location list if not already present
      if (!currentLocations.any((ref) => ref.id == locationId)) {
        currentLocations.add(locationRef);
      }

      // 🔸 Set active location only if not already set
      final Map<String, dynamic> userUpdates = {
        'locations': currentLocations,
      };
      if (activeLocation == null) {
        userUpdates['activeLocation'] = locationRef;
      }

      transaction.update(userRef, userUpdates);

      // 🔸 Add user to location's member list if not already present
      if (!members.any((ref) => ref.id == userId)) {
        members.add(userRef);
        transaction.update(locationRef, {'members': members});
      }
    });
  }

  Future<VisitorPass?> createPass({
    required String userId,
    required String locationId,
    required String startTime,
    required String endTime,
    required String purpose,
    required List<Map<String, dynamic>> visitors,
  }) async {
    try{

      String id = getRandomString(10);

      await _firestore.collection('pass').doc(id).set({
        'userId': userId,
        'locationId': locationId,
        'startTime': startTime,
        'endTime': endTime,
        'purpose': purpose,
        'visitors': visitors,
        'passKey': getRandomString(4),
        'address': userService.user.address,
      });

      VisitorPass? res = await getSavedVisits(id);
      return res;
    } catch (err){
      AppLogger.debug("Error on create pass $err");
      return null;
    }

  }

  Future<VisitorPass?> getSavedVisits(String id) async {
    try{
      var res =  await _firestore
          .collection('pass')
          .doc(id).get();
      AppLogger.debug("pass  ::: ${res.data()}");
      var rest =  VisitorPass.fromJson(res.data()??{});
      return rest;
    } catch (err){
      AppLogger.debug("pass error  ::: $err");
      return null;
    }



    //     .snapshots()
    //     .asyncMap((snapshot) async {
    //   if (!snapshot.exists) return null;
    //
    //   final appUser = AppUser.fromFirestore(snapshot);
    //
    //   // Fetch full location objects
    //   await appUser.fetchLocationData();
    //
    //   user = appUser;
    //   return appUser;
    // });

  }

  /// Remove user from a location and update activeLocation if necessary
  Future<void> leaveLocation({
    required String userId,
    required String locationId,
  }) async {
    final userRef = _firestore.collection('new_user').doc(userId);
    final locationRef = _firestore.collection('locations').doc(locationId);

    await _firestore.runTransaction((transaction) async {
      // 🔹 Read user and location first
      final userSnap = await transaction.get(userRef);
      final locationSnap = await transaction.get(locationRef);

      final userData = userSnap.data() ?? {};
      final locationData = locationSnap.data() ?? {};

      final List<DocumentReference> currentLocations = List<DocumentReference>.from(
        userData['locations'] ?? [],
      );

      final List<DocumentReference> members = List<DocumentReference>.from(
        locationData['members'] ?? [],
      );

      final DocumentReference? activeLocation =
      userData['activeLocation'] != null
          ? userData['activeLocation'] as DocumentReference
          : null;

      // 🔸 Remove location from user's list
      currentLocations.removeWhere((ref) => ref.id == locationId);

      // 🔸 Update user's fields
      final Map<String, dynamic> userUpdates = {
        'locations': currentLocations,
      };

      if (activeLocation?.id == locationId) {
        if (currentLocations.isNotEmpty) {
          userUpdates['activeLocation'] = currentLocations.first;
        } else {
          userUpdates['activeLocation'] = FieldValue.delete();
        }
      }

      transaction.update(userRef, userUpdates);

      // 🔸 Remove user from location's members
      members.removeWhere((ref) => ref.id == userId);
      transaction.update(locationRef, {'members': members});
    });
  }
}

class VisitUser {
  String fullName;
  String email;
  String phoneNumber;

  VisitUser({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
  });
}