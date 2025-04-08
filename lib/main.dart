import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myapp/app.dart';
import 'package:myapp/firebase_options.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  try {
    debugPrint('🚀 Starting initialization...');
    
    await _initializeDependencies();
    _setSystemUIOverlayStyle();
    
    debugPrint('✅ All dependencies initialized');
    
    runApp(MyApp());
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
      debugPrint('🔄 Splash screen removed');
    });
  } catch (e, stack) {
    debugPrint('‼️ Critical initialization error: $e');
    debugPrint('🔍 Stack trace: $stack');
    
    runApp(MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red[50],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red),
              SizedBox(height: 20),
              Text(
                'Initialization Failed',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Error: ${e.toString()}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => main(),
                child: Text('Try Again'),
              ),
            ],
          ),
        ),
      ),
    ));
    FlutterNativeSplash.remove();
  }
}

Future<void> _initializeDependencies() async {
  try {
    debugPrint('🔌 Initializing GetStorage...');
    await GetStorage.init().timeout(Duration(seconds: 5));
    debugPrint('✅ GetStorage ready');

    debugPrint('🔥 Initializing Firebase...');
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ).timeout(Duration(seconds: 10));
    debugPrint('✅ Firebase ready');

  } on TimeoutException catch (e) {
    debugPrint('⏰ Timeout during initialization: $e');
    throw Exception('Initialization timed out. Please check your internet connection.');
  } on PlatformException catch (e) {
    debugPrint('📱 Platform error: $e');
    throw Exception('Device compatibility issue: ${e.message}');
  } catch (e) {
    debugPrint('❌ Unexpected error: $e');
    throw Exception('Initialization failed: ${e.toString()}');
  }
}

void _setSystemUIOverlayStyle() {
  try {
    final isDarkMode = WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
    
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: isDarkMode ? Colors.transparent : Colors.grey[300],
        statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: isDarkMode ? Colors.black : Colors.white,
        systemNavigationBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );
    debugPrint('🎨 UI style configured');
  } catch (e) {
    debugPrint('🎨 UI configuration error: $e');
  }
}