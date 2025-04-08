import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myapp/community_participant/screens/login.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

  Rx<int> currentIndex = 0.obs;
  final PageController pageController = PageController();
  final storage = GetStorage();
   
  /// Returns true if onboarding was completed before
  bool get onboardingCompleted => storage.read('isFirstTime') == false;

  // Update current page when user swipes
  void updateCurrentPage(int index) {
    currentIndex.value = index;
  }

  // Move to the next page
  void nextPage() {
    if (currentIndex.value == 2) {
      storage.write('isFirstTime', false);
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
    storage.write('isFirstTime', false);
    Get.to(() => LoginScreen());
  }

  @override
  void onClose() {
    pageController.dispose(); // Dispose of the PageController to prevent memory leaks
    super.onClose();
  }
}
