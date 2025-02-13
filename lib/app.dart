import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:myapp/core/utils/constants/colors.dart';
import 'package:myapp/core/utils/device/deviceutility.dart';
import 'package:myapp/core/utils/themes/theme.dart';

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
    final bool isDark = TDevice.isDarkMode(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: Scaffold(backgroundColor: isDark? Colors.black:Colors.white ,body: Center(child: CircularProgressIndicator(color: TColors.primaryColor))),
      //onboardingComplete
          //? (isLoggedIn ? custom.NavBar() : LoginScreen())
          //: OnboardingScreen(),  
    );
  }
}
