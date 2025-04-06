import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gate_pass/utils/app_logger.dart';

import '../../../screens/auth/login/login_screen.dart';
import '../../cache/constants.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;

  AuthService() {
    try{
      _user = _auth.currentUser;
      _auth.authStateChanges().listen((User? user) {
        _user = user;
        notifyListeners();
      });
      notifyListeners();
    } catch(err) {
      AppLogger.debug("Error ::: $err");
    }
  }

  User? get currentUser => _user;
  bool get isAuthenticated => _user != null;

  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String phone,
    required String address,
    required String firstName,
    required String lastName,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create user document in Firestore
      await _firestore.collection('new_user').doc(userCredential.user!.uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'username': firstName+lastName,
        'email': email,
        'address': address,
        'phone': phone,
        'profilePicture': null,
        'activeLocation': null,
        'locations': null,
      });

      return userCredential;
    } catch (e) {
      AppLogger.debug("Error:: $e");
      rethrow;
    }
  }

  Future<UserCredential> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update user status
      await _firestore.collection('new_user').doc(userCredential.user!.uid).update({
        'isOnline': true,
      });

      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    // Update user status before signing out
    // if (_user != null) {
    //   await _firestore.collection('new_user').doc(_user!.uid).update({
    //     'isOnline': false,
    //   });
    // }

    await _auth.signOut();
    navigationService.navigateToAndRemoveUntilWidget(const LoginScreen());
  }
}