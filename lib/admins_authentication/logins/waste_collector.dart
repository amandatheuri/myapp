// collector_login.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/admins_authentication/adminauth_controller.dart';
import 'package:myapp/core/utils/constants/colors.dart';

class CollectorLoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _keyController = TextEditingController();
  final AdminAuthController _authController = Get.find();

  CollectorLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('Collector Login', 
      style: Theme.of(context).textTheme.bodySmall,),
      automaticallyImplyLeading: true,
      iconTheme: IconThemeData(color:(TColors.primaryColor)),
       ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _keyController,
              decoration: const InputDecoration(labelText: 'Registration Key'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _authController.loginAdmin(
                _emailController.text.trim(),
                _passwordController.text.trim(),
                'collector',
              ),
              child: Text('Login as Collector', style: Theme.of(context).textTheme.bodySmall,),
            ),
          ],
        ),
      ),
    );
  }
}