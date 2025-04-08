import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:myapp/community_participant/controllers/auth_controller.dart';
import 'package:myapp/community_participant/controllers/token_controller.dart';
import 'package:myapp/community_participant/screens/userprofile.dart';
import 'package:myapp/core/utils/constants/colors.dart';
import 'package:myapp/core/utils/device/deviceutility.dart';
import 'package:myapp/waste_collector/controllers/waste_controller.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    final WasteController wasteController = Get.find();
    final TokenController tokenController = Get.find();
    final bool isDark = TDevice.isDarkMode(context);

    // Initialize data fetching
    wasteController.fetchWasteData();

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 24),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: TColors.primaryColor,
              child: IconButton(
                onPressed: () => Get.to(() => UserProfile()),
                icon: const Icon(Iconsax.user),
                iconSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome Section
                    Row(
                      children: [
                        Text(
                          'Hi',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(width: 9),
                        Obx(() => Text(
                              authController.userName.value.isEmpty
                                  ? 'User'
                                  : authController.userName.value,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                            )),
                      ],
                    ),
                    const SizedBox(height: 25),

                    // Waste Stats Cards
                    Obx(() {
                      return Row(
                        children: [
                          // Today's Waste Card
                          _buildWasteCard(
                            context: context,
                            isDark: isDark,
                            value: wasteController.todayWaste.value,
                            label: "Today",
                            subLabel: "Disposed",
                            icon: Icons.today,
                          ),

                          SizedBox(width: 30),

                          // Lifetime Waste Card
                          _buildWasteCard(
                            context: context,
                            isDark: isDark,
                            value: wasteController.lifetimeWaste.value,
                            label: "Lifetime",
                            subLabel: "Total",
                            icon: Icons.auto_graph,
                          ),
                        ],
                      );
                    }),
                    const SizedBox(height: 16),

                    // Points and Challenges Section
                    Row(
                      children: [
                        Expanded(
                          child: _buildPointsCard(
                            context: context,
                            value: tokenController.tokenBalance.value,
                            label: "Points",
                            icon: Iconsax.coin,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildPointsCard(
                            context: context,
                            value: 0, // Replace with actual challenges count
                            label: "Challenges",
                            icon: Iconsax.award,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // Waste Trend Section
                    Text(
                      'Your disposal trend',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                    ),
                    const SizedBox(height: 20),

                    // HeatMap Calendar
                    Obx(() {
                      Map<DateTime, int> heatmapData = {};
                      for (var entry in wasteController.wasteHistory) {
                        try {
                          if (entry['timestamp'] != null) {
                            DateTime date =
                                (entry['timestamp'] as Timestamp).toDate();
                            date = DateTime(date.year, date.month, date.day);
                            final amount = entry['amount'] ?? 0;
                            heatmapData[date] =
                                (amount * 10).toInt(); // Scale for visibility
                          }
                        } catch (e) {
                          print('Error processing heatmap entry: $e');
                        }
                      }

                      return SizedBox(
                        height: 250,
                        child: HeatMap(
                          defaultColor: Colors.grey[700],
                          colorMode: ColorMode.color,
                          scrollable: true,
                          showText: false,
                          textColor: Colors.grey[700],
                          datasets: heatmapData,
                          colorsets: {
                            1: Colors.green.withOpacity(0.2),
                            5: Colors.green.withOpacity(0.3),
                            10: Colors.green.withOpacity(0.4),
                            30: Colors.green.withOpacity(0.5),
                            50: Colors.green.withOpacity(0.6),
                            70: Colors.green.withOpacity(0.7),
                            100: Colors.green.withOpacity(0.8),
                            150: Colors.green.withOpacity(0.9),
                            200: Colors.green,
                          },
                          onClick: (value) {
                            final dateStr =
                                "${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}";
                            final scaledAmount = heatmapData[value] ?? 0;
                            final originalAmount =
                                (scaledAmount / 10).toStringAsFixed(1);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    '$dateStr: $originalAmount kg disposed'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          startDate:
                              DateTime.now().subtract(Duration(days: 60)),
                          endDate: DateTime.now().add(Duration(days: 30)),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Waste Card Widget
  Widget _buildWasteCard({
    required BuildContext context,
    required bool isDark,
    required double value,
    required String label,
    required String subLabel,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.7),
            offset: Offset(-1, -1),
            blurRadius: 10,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(5, 5),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 24, color: TColors.primaryColor),
              SizedBox(width: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            '${value.toStringAsFixed(1)}kg',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 4),
          Text(
            subLabel,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[700],
                ),
          ),
        ],
      ),
    );
  }

  // Points/Challenges Card Widget
  Widget _buildPointsCard({
    required BuildContext context,
    required int value,
    required String label,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: TColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 24, color: TColors.primaryColor),
              SizedBox(width: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            '$value',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: TColors.primaryColor,
                ),
          ),
        ],
      ),
    );
  }
}
