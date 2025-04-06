import 'package:flutter/material.dart';

import '../../data/cache/constants.dart';
import '../auth/login/login_screen.dart';
import '../home/home.ui.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    await Future.delayed(const Duration(seconds: 2), (){
      if (!mounted) return;
      if (authService.isAuthenticated) {
        navigationService.navigateToAndRemoveUntilWidget(const HomeScreen());
      } else {
        navigationService.navigateToAndRemoveUntilWidget(const LoginScreen());
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Location Sharing App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}