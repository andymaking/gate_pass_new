import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gate_pass/utils/app_logger.dart';
import 'package:gate_pass/utils/remove-null-values-from-json.dart';

import '../../model/location_model.dart';
import '../../model/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LocationModel userSelectedLocation = LocationModel();

  changeLocation(LocationModel locate){
    userSelectedLocation = locate;
  }

  AppUser user = AppUser();


  Stream<AppUser?> getCurrentUserData() {
    final users = _auth.currentUser;
    if (users == null) return Stream.value(null);

    return _firestore
        .collection('new_user')
        .doc(users.uid)
        .snapshots()
        .asyncMap((snapshot) async {
      if (!snapshot.exists) return null;

      final appUser = AppUser.fromFirestore(snapshot);

      // Fetch full location objects
      await appUser.fetchLocationData();

      user = appUser;
      return appUser;
    });
  }

  Future<bool> updateUser({
    String? profilePicture,
    String? firstName,
    String? lastName,
    String? address,
    String? phoneNumber,
    String? activeLocationId,
  }) async {
    try{
      final DocumentReference? locationRef = activeLocationId != null
          ? _firestore.collection('locations').doc(activeLocationId)
          : null;

      final Map<String, dynamic> updates = {
        if (firstName != null) 'firstName': firstName,
        if (lastName != null) 'lastName': lastName,
        if (address != null) 'address': address,
        if (phoneNumber != null) 'phone': phoneNumber,
        if (profilePicture != null) 'profilePicture': profilePicture,
        if (locationRef != null) 'activeLocation': locationRef,
      };

      // Apply updates to Firestore
      await _firestore.collection('new_user').doc(user.id).update(updates);

      return true;
    } catch (err){
      AppLogger.debug("error on upload $err");
      return false;
    }
  }


}