import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/core/utils/constants/imagestrings.dart';
import 'package:myapp/core/utils/constants/textstrings.dart';
import 'package:iconsax/iconsax.dart';
import 'package:myapp/navigation_bar.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Form(  
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: TTextstrings.userFirstName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: TTextstrings.userName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            decoration: const InputDecoration(
              labelText: TTextstrings.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            decoration: const InputDecoration(
              labelText: TTextstrings.phoneNumber,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            obscureText: true,
            decoration: const InputDecoration(
              labelText: TTextstrings.password,
              prefixIcon: Icon(Iconsax.lock),
              suffixIcon: Icon(Iconsax.eye_slash),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => Scaffold(body: NavBar())); 
              },
              child: Text(
                TTextstrings.signUp,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(color: Colors.grey),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  TImageStrings.google,
                  height: 24.0,
                ),
                const SizedBox(width: 8.0),
                Text(
                  TTextstrings.loginWith,
                  style: TextStyle(
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
    );
  }
}
