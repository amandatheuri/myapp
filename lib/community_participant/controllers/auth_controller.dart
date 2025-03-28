import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myapp/community_participant/screens/login.dart';
import 'package:myapp/community_participant/screens/onboarding.dart';
import 'package:myapp/models/usermodel.dart';
import 'package:myapp/navigation_bar.dart';
import 'package:myapp/repository/auth_repo.dart';
import 'package:myapp/repository/user_repo.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final AuthRepo _authRepo = Get.find<AuthRepo>();
  final deviceStorage = GetStorage();

  // Reactive variables for user's name and email
  final userName = RxString('');
  final userEmail = RxString('');

  // Get current user
  User? get currentUser => _authRepo.currentUser;

  @override
  void onReady() {
    super.onReady();
    FlutterNativeSplash.remove();
    screenRedirect();
    fetchUserEmail(); // Fetch the user's email when the app starts
  }

  // ✅ Screen redirection logic (Onboarding -> Login -> Home)
  void screenRedirect() async {
    deviceStorage.writeIfNull('isFirstTime', true);
    bool isFirstTime = deviceStorage.read('isFirstTime') ?? true;

    if (isFirstTime) {
      Get.offAll(() => OnboardingScreen());
    } else if (_authRepo.currentUser != null) {
      Get.offAll(() => NavBar());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }

  // ✅ Fetch the user's email
  void fetchUserEmail() {
    final User? user = _authRepo.currentUser;
    if (user != null) {
      userEmail.value = user.email ?? ''; // Set the user's email
      print('Fetched User Email: ${userEmail.value}');
    }
  }

  // ✅ Login method
  void login(String email, String password) async {
    var user = await _authRepo.signInWithEmailAndPassword(email, password);
    if (user != null) {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        // Use the displayName (username) or fall back to email
        userName.value = currentUser.displayName ?? currentUser.email ?? 'User';
        userEmail.value = currentUser.email ?? ''; // Set the user's email
        print('Login: userName = ${userName.value}, userEmail = ${userEmail.value}');
      }
      Get.offAll(() => NavBar());
    } else {
      Get.snackbar(
        "Login Failed",
        "Invalid email or password",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // ✅ Mark onboarding as completed
  void completeOnboarding() {
    deviceStorage.write('isFirstTime', false);
    Get.offAll(() => LoginScreen());
  }

  // ✅ Signup method
  void signUp(String email, String password, String username) async {
    var user = await _authRepo.signUpWithEmailAndPassword(email, password);
    if (user != null) {
      await updateUserProfile(username); // Set the display name to the username
      userName.value = username; // Update the userName in AuthController
      userEmail.value = email; // Set the user's email
      print('Sign-Up: userName = ${userName.value}, userEmail = ${userEmail.value}'); // Debug statement
      Get.offAll(() => NavBar());
    }
  }

  // ✅ Update user profile
  Future<void> updateUserProfile(String displayName) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updateProfile(displayName: displayName);
      await user.reload(); // Reload the user to reflect changes
      print('Updated displayName: ${user.displayName}');
    }
  }

  // ✅ Google Sign-In method
  void signInWithGoogle() async {
    var userCredential = await _authRepo.signInWithGoogle();
    if (userCredential != null) {
      final User? user = userCredential.user;
      if (user != null) {
        // Use the displayName (from Google) or fall back to email
        userName.value = user.displayName ?? user.email ?? 'User';
        userEmail.value = user.email ?? ''; // Set the user's email
        print('Google Sign-In: userName = ${userName.value}, userEmail = ${userEmail.value}');

        // Check if the user is new (first-time sign-in)
        if (userCredential.additionalUserInfo?.isNewUser ?? false) {
          // Save user data to Firestore
          final newUser = UserModel(
            uid: user.uid,
            firstName: user.displayName?.split(" ").first ?? "",
            lastName: user.displayName?.split(" ").last ?? "",
            userName: user.email?.split("@").first ?? "",
            email: user.email ?? "",
            phoneNumber: user.phoneNumber ?? "",
            token: 0, // Default token balance
            wasteCollected: 0.0, // Default waste collected
            profileSticker: user.photoURL, // Use Google profile picture
          );

          // Save user to Firestore
          final userRepo = Get.put(UserRepo());
          await userRepo.saveUserCredentials(newUser);
        }

        // Navigate to the home screen
        Get.offAll(() => NavBar());
      }
    } else {
      Get.snackbar(
        "Google Sign-In Failed",
        "Something went wrong. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // ✅ Logout method
  void logout() async {
    await _authRepo.signOut();
    userName.value = ''; // Clear the userName
    userEmail.value = ''; // Clear the userEmail
    Get.offAll(() => LoginScreen());
  }
}