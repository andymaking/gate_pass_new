import 'package:flutter/material.dart';

import '../../../data/cache/constants.dart';
import '../../base-vm.dart';
import '../../home/home.ui.dart';

class SignUpViewModel extends BaseViewModel {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  String? errorMessage;

  onChanged(String? val)async {
    formKey.currentState!.validate();
    notifyListeners();
  }



  Future<void> signUp() async {
    startLoader();
    try {
      await authService.signUp(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        password: passwordController.text.trim(),
        address: addressController.text.trim(),
      );
      
      stopLoader();
      notifyListeners();
      navigationService.navigateToAndRemoveUntilWidget(const HomeScreen());
    } catch (e) {
      errorMessage = e.toString();
      stopLoader();
      notifyListeners();
    }
  }

  disposeView() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}