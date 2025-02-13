import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TLoaders {
  // Success Snackbar
  static void successSnackBar({required title, message =''}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      icon: Icon(Icons.check_circle, color: Colors.white),
      duration: Duration(seconds: 3),
    );
  }

  //Error Snackbar
  static void errorSnackBar({required title, message =''}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      icon: Icon(Icons.error, color: Colors.white),
      duration: Duration(seconds: 3),
    );
  }

  //Warning Snackbar
  static void warningSnackBar({required title, message =''}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      icon: Icon(Icons.warning, color: Colors.white),
      duration: Duration(seconds: 3),
    );
  }

  //Loading Snackbar
  static void loadingSnackBar({required title, message =''}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      margin: const EdgeInsets.all(20),
      icon: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(color: Colors.white),
      ),
      duration: const Duration(seconds: 3),
    );
  }
}
