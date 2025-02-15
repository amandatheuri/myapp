import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myapp/repository/auth_repo.dart';
import 'package:myapp/screens/login.dart';
import 'package:myapp/screens/onboarding.dart';
import 'package:myapp/navigation_bar.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final AuthRepo _authRepo = Get.find<AuthRepo>();
  final deviceStorage = GetStorage();

  @override
  void onReady() {
    super.onReady();
     FlutterNativeSplash.remove();
    screenRedirect();
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

  // ✅ Mark onboarding as completed
  void completeOnboarding() {
    deviceStorage.write('isFirstTime', false);
    Get.offAll(() => LoginScreen());
  }

  // ✅ Login method
  void login(String email, String password) async {
    var user = await _authRepo.signInWithEmailAndPassword(email, password);
    if (user != null) {
      Get.offAll(() => NavBar());
    }
  }

  // ✅ Signup method
  void signUp(String email, String password) async {
    var user = await _authRepo.signUpWithEmailAndPassword(email, password);
    if (user != null) {
      Get.offAll(() => NavBar());
    }
  }

  // ✅ Logout method
  void logout() async {
    await _authRepo.signOut();
    Get.offAll(() => LoginScreen());
  }
}
