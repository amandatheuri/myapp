import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:myapp/core/utils/themes/theme.dart';
import 'package:myapp/screens/onboarding.dart';

class MyApp extends StatelessWidget {
  //final bool onboardingComplete;
  //final bool isLoggedIn;

  // Constructor to receive onboardingComplete and isLoggedIn flags
  const MyApp({
    super.key,
    //required this.onboardingComplete,
    //required this.isLoggedIn,
});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: OnboardingScreen()
      //onboardingComplete
          //? (isLoggedIn ? custom.NavBar() : LoginScreen())
          //: OnboardingScreen(),  
    );
  }
}
