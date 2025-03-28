import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myapp/community_participant/controllers/auth_controller.dart';
import 'package:myapp/community_participant/controllers/token_controller.dart';
import 'package:myapp/repository/auth_repo.dart'; 
import 'package:myapp/firebase_options.dart';
import 'package:myapp/waste_collector/controllers/waste_controller.dart';
import 'app.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Get.put(AuthRepo());  
  Get.put(AuthController());
  Get.put(WasteController());
  Get.put(TokenController());

  final bool isDarkMode = WidgetsBinding.instance.window.platformBrightness == Brightness.dark;

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: isDarkMode ? Colors.transparent : Colors.grey,
      statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: isDarkMode ? Colors.black : Colors.white,
      systemNavigationBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
    ),
  );

  runApp(MyApp());
}
