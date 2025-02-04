import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TDevice {
  // Method to hide the keyboard
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  // Method to check if the device is in landscape mode
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  // Method to check if the device is in dark mode
  static bool isDarkMode(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.dark;
  }

  // Method to set the device orientation (useful for waste collection forms)
  static void setOrientation({bool isPortrait = true}) {
    if (isPortrait) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    } else {
      SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
      );
    }
  }

  // Method to retrieve the screen width (e.g., for responsive layouts)
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  // Method to retrieve the screen height
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
  static setFullScreen(BuildContext context){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
  // Method to check if the device has sufficient storage space (simulate for now)
  static Future<bool> hasSufficientStorage() async {
    // This could be implemented using a platform channel to interact with native APIs
    return true; // Placeholder, implement actual check
  }
  static bool isAndroid(){
    return Platform.isAndroid;
  }
  static bool isIOS(){
    return Platform.isIOS;
  }
  // Method to vibrate the device 
  static void vibrateDevice() {
    HapticFeedback.mediumImpact();
  }

  // Method to get device type (e.g., mobile, tablet)
  static String getDeviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return "Mobile";
    } else {
      return "Tablet";
    }
  }

  // Method to check internet connectivity 
  static Future<bool> hasInternetConnection() async {
    // This can be implemented with connectivity_plus package
    return true; // Placeholder
  }

  static getappbarHeight(){
    return AppBar().preferredSize.height;
  }

  static getbottomappbarheight (){
    return kBottomNavigationBarHeight;
  }
}
