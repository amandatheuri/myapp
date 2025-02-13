import 'package:flutter/material.dart';
import 'package:myapp/core/utils/constants/textstrings.dart';
import 'package:myapp/widgets/signupwidget/signupform.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              const SizedBox(height: 25),
              Text(
                TTextstrings.appName,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 5.0),
              Text(
                TTextstrings.signUpTitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[700], fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40.0),
              SignUpForm(isDarkMode: isDarkMode)
            ],
          ),
        ),
      ),
    );
  }
}
