import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/community_participant/controllers/auth_controller.dart';
import 'package:myapp/community_participant/screens/sign_up.dart';
import 'package:myapp/core/utils/constants/colors.dart';
import 'package:myapp/core/utils/constants/imagestrings.dart';
import 'package:myapp/core/utils/constants/textstrings.dart';
import 'package:myapp/community_participant/screens/forgot_password.dart';
import 'package:myapp/waste_collector/controllers/waste_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    // Get the current theme mode
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Initialize AuthController
    final AuthController authController = Get.put(AuthController());
    final WasteController wasteController = Get.put(WasteController());

    // Controllers for email and password
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            children: [
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                  ),
                  Image(
                    height: 160,
                    image: AssetImage('assets/logos/app_logo.png'),
                  ),
                  // Temporary placeholder

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
                      controller: emailController,
                      style: TextStyle(fontSize: 16),
                      cursorColor: TColors.primaryColor,
                      decoration: InputDecoration(
                        labelText: TTextstrings.email,
                        hintText: TTextstrings.email,
                        prefixIcon: const Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: passwordController,
                      style: TextStyle(fontSize: 16),
                      cursorColor: TColors.primaryColor,
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
                        Text(
                          TTextstrings.rememberMe,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Get.to(() => const ForgotPassword());
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.color, // Set text color
                          ),
                          child: Text(
                            TTextstrings.forgotPassword,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight
                                          .bold, // Customize font weight as needed
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
                        onPressed: () async {
                          final String email = emailController.text.trim();
                          final String password = passwordController.text.trim();

                          if (email.isEmpty || password.isEmpty) {
                            // Show an error message if fields are empty
                            Get.snackbar(
                              "Error",
                              "Please enter your email and password",
                              snackPosition: SnackPosition.BOTTOM,
                            );
                            return;
                          }

                          // Call the login method from AuthController
                          authController.login(email, password);
                        },
                        child: Text(
                          TTextstrings.login,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                          Get.to(() => SignUpScreen());
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: TColors.primaryColor,
                          ),
                        ),
                        child: Text(
                          TTextstrings.signUp,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
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
                   authController.signInWithGoogle();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isDarkMode ? Colors.transparent : Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: Colors.grey),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      TImageStrings.google, // Path to your Google logo
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