import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/superadmin/controller/superadmin_controller.dart';
import 'package:myapp/superadmin/widgets/widgets.dart';

class SuperAdminDashboard extends StatelessWidget {
  final AdminController _adminController = Get.put(AdminController());

  SuperAdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _adminController.logout,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            FeatureCard(
              icon: Icons.store,
              title: 'Manage Stores',
              onTap: () => Get.to(() => StoreManagementScreen()),
            ),
            FeatureCard(
              icon: Icons.people,
              title: 'Manage Collectors',
              onTap: () => Get.to(() => CollectorManagementScreen()),
            ),
            FeatureCard(
              icon: Icons.analytics,
              title: 'View Analytics',
              onTap: () => Get.to(() => AnalyticsScreen()),
            ),
            FeatureCard(
              icon: Icons.receipt,
              title: 'Generate Reports',
              onTap: _adminController.generateReport,
            ),
          ],
        ),
      ),
    );
  }
}

class CollectorManagementScreen {
}

class AnalyticsScreen {
}

class StoreManagementScreen {
}