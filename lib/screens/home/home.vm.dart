import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gate_pass/data/cache/constants.dart';
import 'package:gate_pass/data/model/location_model.dart';
import 'package:gate_pass/screens/base-vm.dart';
import 'package:gate_pass/screens/home/bottom_nav/bottom_nav.ui.dart';

import '../../data/model/user_model.dart';
import '../../utils/app_logger.dart';

class HomeViewModel extends BaseViewModel {

  HomeViewModel(){
    listenToFirestore();
  }

  TextEditingController controller = TextEditingController();

  AppUser? userInfo;

  Stream<AppUser?> getUserInfo() async*{
    userService.getCurrentUserData().listen((user){
      userInfo = user;
      notifyListeners();
    });
    if(userInfo?.activeLocation != null){
      navigationService.navigateToAndRemoveUntilWidget(const BottomNavigationScreen());
    }
    yield userInfo;
  }

  joinLocation(String locationId)async {
    startLoader();
    await locationService.joinLocation(userId: userInfo?.id??"", locationId: locationId);
    stopLoader();
  }


  List<LocationModel> locations = [];
  List<LocationModel> filteredLocation = [];

  onChanged(String? val) async {
    if(controller.text.trim().isEmpty){
      filteredLocation = locations;
    }else{
      filteredLocation = locations.where((test)=> (test.name??"").contains(controller.text.trim())).toList();
    }
    notifyListeners();
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


}