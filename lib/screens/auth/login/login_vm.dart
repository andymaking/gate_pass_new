import 'package:flutter/material.dart';

import '../../../data/cache/constants.dart';
import '../../base-vm.dart';
import '../../home/home.ui.dart';

class LoginViewModel extends BaseViewModel {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? errorMessage;

  onChanged(String? val)async {
    formKey.currentState!.validate();
    notifyListeners();
  }

  Future<void> signIn() async {
    startLoader();

    try {
      await authService.signIn(
        emailController.text.trim(),
        passwordController.text,
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}