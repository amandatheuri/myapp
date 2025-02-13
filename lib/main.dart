import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/firebase_options.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); 

  final bool isDarkMode = WidgetsBinding.instance.window.platformBrightness == Brightness.dark;

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: isDarkMode ? Colors.transparent : Colors.grey,
      statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: isDarkMode ? Colors.black : Colors.white,
      systemNavigationBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
    ),
  );

  // Uncomment if you need onboarding/login state
  // final prefs = await SharedPreferences.getInstance();
  // bool onboardingComplete = prefs.getBool('onboardingComplete') ?? false;
  // bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(
    MyApp(
      // onboardingComplete: onboardingComplete,
      // isLoggedIn: isLoggedIn,
    ),
  );
}
