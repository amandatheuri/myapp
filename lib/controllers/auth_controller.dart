import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../screens/login.dart';
import '../screens/onboarding.dart';

class AuthController extends GetxController {
static AuthController instance = Get.find();
//variables
final deviceStorage = GetStorage();
//functions
//main.dart file checks whether splash has finished loading
@override
  void onReady(){
FlutterNativeSplash.remove();
screenRedirect();
}
screenRedirect()async{
  deviceStorage.writeIfNull('isFirstTime', true);
  deviceStorage.read('isFirstTime') == true ? Get.offAll(()=>OnboardingScreen()) : Get.offAll(()=>LoginScreen());
}
//create user, log in and log out functions
}