// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/core/utils/device/deviceutility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final bool isDarkMode = WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
   WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: isDarkMode?  Colors.transparent:Colors.grey, 
    statusBarIconBrightness: isDarkMode? Brightness.light: Brightness.dark,
    systemNavigationBarColor: isDarkMode? Colors.black: Colors.white, 
    systemNavigationBarIconBrightness: isDarkMode? Brightness.light:Brightness.dark, 
  ));
  //WidgetsFlutterBinding.ensureInitialized();
  //final prefs = await SharedPreferences.getInstance();
  //bool onboardingComplete = prefs.getBool('onboardingComplete') ?? false;
  //bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(
    MyApp(
      //onboardingComplete: onboardingComplete,
      //isLoggedIn: isLoggedIn,
    )
  );
}
