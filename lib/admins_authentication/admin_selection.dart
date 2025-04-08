// role_selection_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/admins_authentication/logins/superadmin_login.dart';
import 'package:myapp/admins_authentication/logins/waste_collector.dart';
import 'package:myapp/community_participant/screens/login.dart';
import 'package:myapp/core/utils/constants/colors.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Admin Login',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 40),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Get.offAll(SuperAdminLoginScreen()),
                child: Text('Super Admin',
                    style: Theme.of(context).textTheme.bodySmall),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Get.to(CollectorLoginScreen()),
                child: Text('Waste Collector',
                    style: Theme.of(context).textTheme.bodySmall),
              ),
            ),
            const SizedBox(height: 40),
            TextButton(
              onPressed: () => Get.to(LoginScreen()),
              child: Text(
                '← Back to User Login',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: TColors.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
