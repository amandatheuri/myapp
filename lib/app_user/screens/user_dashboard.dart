import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:myapp/app_user/screens/userprofile.dart';
import 'package:myapp/controllers/auth_controller.dart';
import 'package:myapp/controllers/token_controller.dart';
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

    // Fetch token balance and waste history when the widget is built
    wasteController.fetchTokenBalance(authController.userEmail.value);
    wasteController.fetchWasteHistory(authController.userEmail.value);

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
                onPressed: () {
                  Get.to(() => UserProfile());
                },
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
                    Row(
                      children: [
                        /// Welcome text
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
                    Row(
                      children: [
                        // Total Waste Deposited Card
                        Obx(() {
                          double totalWaste = wasteController.wasteHistory.fold(
                              0,
                              (sum, entry) =>
                                  sum + (entry['totalAmount'] ?? 0));

                          return Container(
                            height: TDevice.getScreenHeight(context) * 0.25,
                            width: TDevice.getScreenWidth(context) * 0.4,
                            decoration: BoxDecoration(
                              color:
                                  isDark ? Colors.grey[900] : Colors.grey[200],
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${totalWaste.toStringAsFixed(1)}kg',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 20),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Disposed',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Colors.grey[700],
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        const Spacer(),
                        Expanded(
                          flex: 6,
                          child: Column(
                            children: [
                              Obx(() => TextButton(
                                    onPressed: () {},
                                    child: Column(
                                      children: [
                                        Text(
                                          '${wasteController.tokenBalance.value}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium
                                              ?.copyWith(),
                                        ),
                                        Text(
                                          'Points',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: Colors.grey[700],
                                              ),
                                        ),
                                      ],
                                    ),
                                  )),
                              const SizedBox(height: 7),
                              TextButton(
                                onPressed: () {},
                                child: Column(
                                  children: [
                                    Text(
                                      '0', // Replace with dynamic data
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(),
                                    ),
                                    Text(
                                      'New Challenges',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: Colors.grey[700],
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
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
                      print(
                          'Waste History in UI: ${wasteController.wasteHistory}');

                      // Generate heatmap dataset from waste history
                      Map<DateTime, int> heatmapData = {};
                      for (var entry in wasteController.wasteHistory) {
                        try {
                          // Check if timestamp exists and handle different possible formats
                          if (entry['timestamp'] != null) {
                            DateTime date;

                            if (entry['timestamp'] is Timestamp) {
                              // Handle Firestore Timestamp
                              date = (entry['timestamp'] as Timestamp).toDate();
                            } else if (entry['timestamp'] is Map &&
                                entry['timestamp']['_seconds'] != null) {
                              // Handle serialized Timestamp
                              int seconds = entry['timestamp']['_seconds'];
                              date = DateTime.fromMillisecondsSinceEpoch(
                                  seconds * 1000);
                            } else {
                              // Skip if timestamp format is unknown
                              print(
                                  'Unknown timestamp format in entry: $entry');
                              continue;
                            }

                            // Normalize the date to remove time component
                            date = DateTime(date.year, date.month, date.day);

                            // Add or update the entry in the heatmap data
                            final value = entry['totalAmount'];
                            if (value is num) {
                              // Convert kg to integer scale for heatmap (multiply by 10 to preserve decimal)
                              int scaledValue = (value * 10).toInt();

                              // Set minimum value to 1 if waste was deposited (for visibility)
                              if (scaledValue > 0 && scaledValue < 1)
                                scaledValue = 1;

                              // If date already exists, add to the value
                              heatmapData[date] =
                                  (heatmapData[date] ?? 0) + scaledValue;
                            }
                          }
                        } catch (e) {
                          print('Error processing waste history entry: $e');
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
                          // Custom color sets based on the waste amount
                          // These values represent the scaled values (kg * 10)
                          colorsets: {
                            1: Colors.green.withOpacity(0.2), // 0.1kg
                            5: Colors.green.withOpacity(0.3), // 0.5kg
                            10: Colors.green.withOpacity(0.4), // 1kg
                            30: Colors.green.withOpacity(0.5), // 3kg
                            50: Colors.green.withOpacity(0.6), // 5kg
                            70: Colors.green.withOpacity(0.7), // 7kg
                            100: Colors.green.withOpacity(0.8), // 10kg
                            150: Colors.green.withOpacity(0.9), // 15kg
                            200: Colors.green, // 20kg and above
                          },
                          onClick: (value) {
                            // Show more details when tapping on a date
                            final dateStr =
                                "${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}";

                            // Get the original (unscaled) value
                            final scaledAmount = heatmapData[value] ?? 0;
                            final originalAmount =
                                (scaledAmount / 10).toStringAsFixed(1);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    '$dateStr: $originalAmount kg of waste disposed'),
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
                    Container(
                      width: TDevice.getScreenWidth(context),
                      height: TDevice.getScreenHeight(context) * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey[700]!),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Icon(Iconsax.map, size: 50),
                          SizedBox(height: 5),
                          Text(
                            'To be continued...',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
