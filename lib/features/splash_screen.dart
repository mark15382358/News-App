import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/local_data/preference_manager.dart';
import 'package:news_app/features/onboarding/onboarding_screen.dart';
import 'package:news_app/auth/login.dart';
import 'package:news_app/main/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    _navigateAfterSplash();
  }

  void _navigateAfterSplash() {
    Future.delayed(Duration(seconds: 2)).then((_) {
      final bool onBoardingComplete =
          PreferencesManager().getBool("onboarding_complete") ?? false;
      final bool isLoggedIn =
          PreferencesManager().getBool("is_logged_in") ?? false;
      if (!onBoardingComplete) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => OnboardingScreen()),
        );
      } else if (!isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => 
          MainScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => MainScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image(
        image: AssetImage("assets/images/splash_screen.png"),
        width: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }
}
