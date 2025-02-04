import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/screens/login.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

  Rx<int> currentIndex = 0.obs;
  final PageController pageController = PageController();

  // Update current page when user swipes
  void updateCurrentPage(int index) {
    currentIndex.value = index;
  }

  // Move to the next page
  void nextPage() {
    if (currentIndex.value == 2) {
      Get.to(() => LoginScreen());
    } else {
      int nextPage = currentIndex.value + 1;
      pageController.animateToPage(
        nextPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Skip to the last page and navigate to login
  void skipPage() {
    pageController.jumpToPage(2);
    Future.delayed(Duration(milliseconds: 500), () {
      Get.to(() => LoginScreen());
    });
  }

  @override
  void onClose() {
    pageController.dispose(); // Dispose of the PageController to prevent memory leaks
    super.onClose();
  }
}
