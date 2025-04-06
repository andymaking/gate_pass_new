import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../data/cache/constants.dart';
import '../../../data/model/location_model.dart';
import '../../../data/model/user_model.dart';
import '../../../utils/app_logger.dart';
import '../../base-vm.dart';
import '../bottom_nav/bottom_nav.ui.dart';

class CommunityViewModel extends BaseViewModel {
  List<LocationModel> locations = [];
  List<LocationModel> filteredLocation = [];
  TextEditingController controller = TextEditingController();
  AppUser userInfo = AppUser();

  init(){
    userInfo = userService.user;
    listenToFirestore();
    getUserInfo();
    notifyListeners();
  }

  leaveChannel(String communityID) async {
    startLoader();
    await locationService.leaveLocation(
      userId: userService.user.id??"",
      locationId: communityID
    ).whenComplete(getUserInfo);
    stopLoader();
    notifyListeners();
  }

  Stream<AppUser?> getUserInfo() async*{
    userService.getCurrentUserData().listen((user){
      userInfo = user?? userInfo;
      notifyListeners();
    });
    // if(userInfo.activeLocation != null){
    //   navigationService.navigateToAndRemoveUntilWidget(const BottomNavigationScreen());
    // }
    yield userInfo;
  }

  void listenToFirestore() {
    FirebaseFirestore.instance
        .collection("locations")
        .snapshots()
        .listen((snapshot) async {
      for (var doc in snapshot.docs) {
        try {
          // Step 1: Parse the location document
          LocationModel location = LocationModel.fromFirestore(doc);

          // Step 2: Fetch the user details from memberRefs
          location.fetchMembers();

          // Step 3: Update local list
          final index = locations.indexWhere((loc) => loc.id == location.id);
          if (index != -1) {
            locations[index] = location;
          } else {
            locations.add(location);
          }

        } catch (e) {
          AppLogger.debug("Error parsing LocationModel: $e | Document: ${doc.id}");
        }
      }

      onChanged(""); // Callback
      notifyListeners(); // Update UI
    });
  }

  joinLocation(String locationId)async {
    startLoader();
    var res = await userService.updateUser(activeLocationId: locationId).whenComplete(getUserInfo);
    if(res){
      navigationService.navigateToAndRemoveUntilWidget(const BottomNavigationScreen(initialIndex: 4,));
    }
    stopLoader();
    notifyListeners();
  }

  join(String locationId)async {
    startLoader();
    await locationService.joinLocation(userId: userInfo.id??"", locationId: locationId).whenComplete(getUserInfo);
    stopLoader();
    notifyListeners();
  }

  onChanged(String? val) async {
    if(controller.text.trim().isEmpty){
      filteredLocation = locations;
    }else{
      filteredLocation = locations.where((test)=> (test.name??"").toLowerCase().contains(controller.text.trim().toLowerCase())).toList();
    }
    notifyListeners();
  }

}