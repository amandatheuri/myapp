import 'package:flutter/material.dart';
import 'package:myapp/community_participant/widgets/signupwidget/signupform.dart';
import 'package:myapp/core/utils/constants/textstrings.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Account',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
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
