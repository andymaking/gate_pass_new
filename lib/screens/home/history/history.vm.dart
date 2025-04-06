import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gate_pass/screens/base-vm.dart';

import '../../../data/cache/constants.dart';
import '../../../data/model/vistor_pass_model.dart';
import '../../../utils/app_logger.dart';
import '../book/passcode.ui.dart';

class HistoryViewModel extends BaseViewModel {

  HistoryViewModel(){
    listenToFirestore();
  }

  List<VisitorPass> myPass = [];

  goToPassCodeScreen(VisitorPass pass) async {
    navigationService.navigateToRoute(PassCodeScreen(pass: pass, location: userService.user.activeLocation!.location!,));
  }

  void listenToFirestore() {
    List<VisitorPass> passes = [];
    List<VisitorPass> updatePasses = [];
    FirebaseFirestore.instance
        .collection("pass")
        .snapshots()
        .listen((snapshot) async {
      for (var doc in snapshot.docs) {
        try {
          // Step 1: Parse the location document

          Map<String, dynamic> theResponse = doc.data();
          theResponse["id"] = doc.id;

          VisitorPass pass = VisitorPass.fromJson(theResponse);

          // Step 2: Update local list
          final index = passes.indexWhere((loc) => loc.id == pass.id);
          if (index != -1) {
            passes[index] = pass;
          } else {
            passes.add(pass);
          }

        } catch (e) {
          AppLogger.debug("Error parsing LocationModel: $e | Document: ${doc.id}");
        }
      }

      updatePasses = passes.where((test)=> test.userId == userService.user.id).toList();
      myPass = updatePasses.where((test)=> test.locationId == userService.user.activeLocation?.id).toList();

      AppLogger.debug("Length of my list = ${myPass.length}");
      notifyListeners(); // Update UI
    });
  }

}