import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/core/utils/constants/colors.dart';
import 'package:myapp/core/utils/constants/imagestrings.dart';
import 'package:myapp/core/utils/constants/textstrings.dart';
import 'package:myapp/navigation_bar.dart';
import 'package:myapp/screens/forgot_password.dart';
import 'package:myapp/screens/sign_up.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current theme mode
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 18.0,
            right: 18.0,
            top: 56.0,
            bottom: 24.0,
          ),
          child: Column(
            children: [
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                  ),
                  Image(
                    height: 160,
                    image: AssetImage(TImageStrings.logo),
                  ),
                  Text(
                    TTextstrings.welcomeBack,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    TTextstrings.loginToContinue,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 40.0),

              Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: TTextstrings.email,
                        hintText: TTextstrings.email,
                        prefixIcon: const Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: TTextstrings.password,
                        hintText: TTextstrings.password,
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: const Icon(Icons.visibility),
                      ),
                    ),
                     Row(
                      children: [
                        Checkbox(
                          value: true,
                          side: const BorderSide(
                            color: TColors.primaryColor,
                          ),
                          onChanged: (value) {},
                        ),
                        Text(TTextstrings.rememberMe, style: Theme.of(context).textTheme.bodySmall,),
                        const Spacer(
                        ),
                        TextButton(
                        onPressed: (){
                        Get.to(() => const ForgotPassword());
                         },
                        style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).textTheme.bodySmall?.color, // Set text color
                        ),
                        child: Text(
                        TTextstrings.forgotPassword,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold, // Customize font weight as needed
                        ),
                        ),
                         ),

                      ],
                    ),
                    const SizedBox(height: 5.0),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: (){
                        Get.to(() => NavBar());
                        },
                        child: Text(
                          TTextstrings.login,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () {
                          // Navigate to sign-up screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUpScreen()),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: TColors.primaryColor,
                          ),
                        ),
                        child: Text(
                          TTextstrings.signUp,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// Google sign-in button
              const SizedBox(height: 45.0),
             
              ElevatedButton(
                onPressed: () {
                },
                style: ElevatedButton.styleFrom(
                  // Conditional styling based on theme mode
                  backgroundColor:  Colors.transparent, // Light mode: white background
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      TImageStrings.google,  // Path to your Google logo
                      height: 24.0, // Adjust height as needed
                    ),
                    const SizedBox(width: 8.0), // Space between logo and text
                    Text(
                      TTextstrings.loginWith,
                      style: TextStyle(
                        // Conditional text color based on theme mode
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
