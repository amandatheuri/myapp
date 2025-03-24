import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app_user/screens/success.dart';
import 'package:myapp/core/utils/constants/imagestrings.dart';
import 'package:myapp/core/utils/helpers/network_manager.dart';
import 'package:myapp/core/utils/loaders/TLoaders.dart';
import 'package:myapp/core/utils/popups/fullscreen_popup.dart';
import 'package:myapp/models/usermodel.dart';
import 'package:myapp/navigation_bar.dart';
import 'package:myapp/repository/auth_repo.dart';
import 'package:myapp/repository/user_repo.dart';

class SignupController extends GetxController {
  static SignupController instance = Get.find();

  // Variables
  final hidePassword = true.obs;
  final checkBox = true.obs;
  final userFirstName = TextEditingController();
  final userLastName = TextEditingController();
  final userName = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // AuthRepo instance
  final AuthRepo _authRepo = Get.find<AuthRepo>();

  // Google Sign-In method
  void signInWithGoogle() async {
    try {
      // Start loading
      TFullscreenLoader.openLoadingDialog(
          'Signing in with Google...', TImageStrings.loading);

      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullscreenLoader.stopLoading();
        return;
      }

      // Trigger Google Sign-In
      final userCredential = await _authRepo.signInWithGoogle();
      if (userCredential != null) {
        final User? user = userCredential.user;

        if (user != null) {
          // Check if the user is new (first-time sign-in)
          if (userCredential.additionalUserInfo?.isNewUser ?? false) {
            // Save user data to Firestore
            final newUser = UserModel(
              email: user.email ?? "",
              firstName: user.displayName?.split(" ").first ?? "",
              lastName: user.displayName?.split(" ").last ?? "",
              phoneNumber: user.phoneNumber ?? "",
              profileSticker: user.photoURL, // Use Google profile picture
              token: 0, // Default token balance
              uid: user.uid,
              userName: user.email?.split("@").first ?? "",
              wasteCollected: 0.0, // Default waste collected
            );

            // Save user to Firestore
            final userRepo = Get.put(UserRepo());
            await userRepo.saveUserCredentials(newUser);
          }

          // Stop loading
          TFullscreenLoader.stopLoading();

          // Show success message
          TLoaders.successSnackBar(
              title: 'Success', message: 'Signed in with Google successfully!');

          // Navigate to the home screen
          Get.offAll(() => NavBar());
        }
      } else {
        TFullscreenLoader.stopLoading();
        TLoaders.errorSnackBar(
            title: 'Error',
            message: 'Google Sign-In failed. Please try again.');
      }
    } catch (e) {
      TFullscreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  // Existing signupUser method
  void signupUser() async {
    try {
      // Start loading
      TFullscreenLoader.openLoadingDialog(
          'Processing your information...', TImageStrings.loading);

      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullscreenLoader.stopLoading();
        return;
      }

      // Form validation
      if (!formKey.currentState!.validate()) {
        TFullscreenLoader.stopLoading();
        return;
      }

      // Register and store user in Firebase
      final userCredential = await _authRepo.signUpWithEmailAndPassword(
          email.text.trim(), password.text.trim());

      // Store user in Firestore
      final newUser = UserModel(
        email: email.text.trim(),
        firstName: userFirstName.text.trim(),
        lastName: userLastName.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profileSticker: null,
        token: 0,
        uid: userCredential?.user?.uid ?? '',
        userName: userName.text.trim(),
        wasteCollected: 0.0,
      );

      final userRepo = Get.put(UserRepo());
      await userRepo.saveUserCredentials(newUser);

      // Stop loading
      TFullscreenLoader.stopLoading();

      // Show success message
      TLoaders.successSnackBar(
          title: 'Congratulations', message: 'Your account has been created!');

      // Navigate to success screen
      Get.to(() => const Success());
    } catch (e) {
      TFullscreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}
