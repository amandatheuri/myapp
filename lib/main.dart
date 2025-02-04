// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';

void main() async {
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
