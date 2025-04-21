import 'package:flutter/material.dart';
import 'package:absensi_ycalp/page/screens/login_screen.dart';

class OnboardingController {
  final PageController pageController = PageController();
  int currentPage = 0;

  void onPageChanged(int index, VoidCallback updateState) {
    currentPage = index;
    updateState();
  }

  void nextPage(BuildContext context, VoidCallback updateState) {
    if (currentPage < 2) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      goToLogin(context);
    }
  }

  void prevPage() {
    if (currentPage > 0) {
      pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void skip(BuildContext context) {
    goToLogin(context);
  }

  void goToLogin(BuildContext context) {
    {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    }
    print('Navigasi ke login page');
  }

  void dispose() {
    pageController.dispose();
  }
}
