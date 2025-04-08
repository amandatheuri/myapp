import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/bindings/general_bindings.dart';
import 'package:myapp/community_participant/controllers/onboardingcontroller.dart';
import 'package:myapp/community_participant/screens/login.dart';
import 'package:myapp/community_participant/screens/onboarding.dart';
import 'package:myapp/community_participant/screens/user_dashboard.dart';
import 'package:myapp/admins_authentication/admin_service/adminauth_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Waste Management System',
      initialBinding: GeneralBindings(),
            debugShowCheckedModeBanner: false,
      home: const _AppLoader(),
    );
  }
}
  

class _AppLoader extends StatelessWidget {
  const _AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final onboardingController = Get.find<OnboardingController>();
    debugPrint('✅Onboarding completed: ${onboardingController.onboardingCompleted}');
    final onboardingComplete = onboardingController.onboardingCompleted;

    // Ensure AuthService is registered before using it
    final authService = Get.find<AuthService>();
    debugPrint('🔐Auth service initialized');
    final isLoggedIn = authService.currentUser != null;

    // Navigate accordingly
    Future.microtask(() {
      if (onboardingComplete) {
        if (isLoggedIn) {
          Get.offAll(() => const UserDashboard());
        } else {
          Get.offAll(() => const LoginScreen());
        }
      } else {
        Get.offAll(() => OnboardingScreen());
      }
    });

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
