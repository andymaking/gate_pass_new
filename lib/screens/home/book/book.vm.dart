import 'package:flutter/material.dart';
import 'package:gate_pass/data/cache/constants.dart';
import 'package:gate_pass/screens/base-vm.dart';
import 'package:gate_pass/screens/home/book/passcode.ui.dart';
import 'package:gate_pass/utils/utils.dart';

import '../../../data/services/web/location_service.dart';

class BookViewModel extends BaseViewModel {
  TextEditingController purposeController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  BookViewModel() {
    isSingle = passType[0];
    addVisitor(); // Always start with one visitor field
  }

  DateTime? startDate;
  DateTime? endDate;

  submit() async {
    startLoader();
    try{
      List<Map<String, dynamic>> visitors = [];

      for(var ds in visitorsInput){
        visitors.add({
          "fullName": ds.fullName.text.trim(),
          "email": ds.email.text.trim(),
          "phoneNumber": ds.phoneNumber.text.trim(),
        });
      }

      var res = await locationService.createPass(
        userId: userService.user.id??"",
        locationId: userService.user.activeLocation?.id??"",
        startTime: startDate.toString(),
        endTime: endDate.toString(),
        purpose: purposeController.text.trim(),
        visitors: visitors
      );

      stopLoader();
      notifyListeners();

      if(res!= null){
        navigationService.navigateToAndRemoveUntilWidget(PassCodeScreen(pass: res, location: userService.user.activeLocation!.location!,));
      }
    } catch (err) {
      stopLoader();
      notifyListeners();
    }
  }

  Future<DateTime?> pickStartDateTime() async {
    BuildContext context = navigationService.context;
    DateTime initialDate = DateTime.now();

    // Pick Date
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: initialDate,
      lastDate: endDate ?? DateTime(2100),
      builder: (_, child){
        return Theme(
          data: ThemeData(
            primaryColor: Colors.white,
            colorScheme: ColorScheme.dark(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white, // Example color
              surface: Colors.white, // Example color
              onSurface: Colors.black, // Example color
            ),
          ),
          child: child!,
        );
      }
    );

    if (pickedDate == null) return null;

    // Pick Time
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDate),
      builder: (_, child){
        return Theme(
          data: ThemeData(
            primaryColor: Colors.white,
            colorScheme: ColorScheme.dark(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white, // Example color
              surface: Colors.white, // Example color
              onSurface: Colors.black, // Example color
            ),
          ),
          child: child!,
        );
      }
    );

    if (pickedTime == null) return null;

    // Combine Date and Time
    DateTime selected = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    startDate = selected;
    startDateController = TextEditingController(text: Utils.formatDateTime(selected));
    isSingle? onChanged("") : onChanged2("");
    notifyListeners();
    return startDate;
  }

  Future<DateTime?> pickEndDateTime() async {
    BuildContext context = navigationService.context;
    DateTime initialDate = DateTime.now();

    // Pick Date
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: startDate ?? initialDate,
      firstDate: startDate ?? initialDate,
      lastDate: DateTime(2100),
      builder: (_, child){
        return Theme(
          data: ThemeData(
            primaryColor: Colors.white,
            colorScheme: ColorScheme.dark(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white, // Example color
              surface: Colors.white, // Example color
              onSurface: Colors.black, // Example color
            ),
          ),
          child: child!,
        );
      }
    );

    if (pickedDate == null) return null;

    // Pick Time
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDate),
      builder: (_, child){
        return Theme(
          data: ThemeData(
            primaryColor: Colors.white,
            colorScheme: ColorScheme.dark(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white, // Example color
              surface: Colors.white, // Example color
              onSurface: Colors.black, // Example color
            ),
          ),
          child: child!,
        );
      }
    );

    if (pickedTime == null) return null;

    // Combine Date and Time
    DateTime selected = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    endDate = selected;
    endDateController = TextEditingController(text: Utils.formatDateTime(selected));
    isSingle? onChanged("") : onChanged2("");
    notifyListeners();
    return endDate;
  }


  List<bool> passType = [true, false];
  bool isSingle = true;

  void changeType(bool val) {
    isSingle = val;
    notifyListeners();
  }

  final formKey2 = GlobalKey<FormState>();
  final List<VisitUserInput> visitorsInput = [];

  void onChanged(String? val) {
    formKey.currentState?.validate();
    notifyListeners();
  }

  void onChanged2(String? val) {
    formKey2.currentState?.validate();
    notifyListeners();
  }

  void addVisitor() {
    visitorsInput.add(VisitUserInput());
    onChanged2("");
    notifyListeners();
  }

  void removeVisitor(int index) {
    if (visitorsInput.length > 1) {
      visitorsInput[index].dispose();
      visitorsInput.removeAt(index);
      onChanged2("");
      notifyListeners();
    }
  }

  List<VisitUser> getVisitors() {
    return visitorsInput.map((input) {
      return VisitUser(
        fullName: input.fullName.text,
        email: input.email.text,
        phoneNumber: input.phoneNumber.text,
      );
    }).toList();
  }

  void disposeVisitors() {
    for (var visitor in visitorsInput) {
      visitor.dispose();
    }
    visitorsInput.clear();
  }
}


class VisitUserInput {
  final TextEditingController fullName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();

  void dispose() {
    fullName.dispose();
    email.dispose();
    phoneNumber.dispose();
  }

  bool isValid() {
    return fullName.text.isNotEmpty &&
        email.text.isNotEmpty &&
        phoneNumber.text.isNotEmpty;
  }
}