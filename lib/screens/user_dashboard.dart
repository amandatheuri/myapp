import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:myapp/core/utils/constants/colors.dart';
import 'package:myapp/core/utils/device/deviceutility.dart';
import 'package:myapp/screens/userprofile.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = TDevice.isDarkMode(context);

    return Scaffold(
      body: Stack(
        
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                       ///welcome text
                        Text(
                          'Hi',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                        ),
                         const SizedBox(width: 9),
                        Text(
                          'Amanda',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const Spacer(),
                         ///profile icon button
                        IconButton(
                          onPressed: () {
                            Get.to(()=> UserProfile());
                          },
                          icon: const Icon(Iconsax.user),
                          iconSize: 30,
                          color: Colors.grey[700],
                        ),
                        
                       
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              '200g',
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                fontSize: 50,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Disposed',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 45),
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green.withOpacity(0.5),
                                spreadRadius: isDark ? -12 : -6,
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: VerticalDivider(
                            color: Colors.grey[700],
                            thickness: 1,
                            indent: 10,
                            endIndent: 10,
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex:6,
                          child: Column(
                            children: [
                              TextButton(
                                  onPressed: () {},
                                  child: Column(
                                    children: [
                                      Text(
                                        '150',
                                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(),
                                      ),
                                      Text(
                                        'Points',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              
                              const SizedBox(height: 7),
                              
                                TextButton(
                                  onPressed: () {},
                                  child: Column(
                                    children: [
                                      Text(
                                        '4',
                                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(),
                                      ),
                                      Text(
                                        'New Challenges',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // HeatMap Calendar
                    SizedBox(
                      height: 250, // Explicit height to avoid layout issues
                      child: HeatMap(
                        defaultColor: Colors.grey[700],
                        colorMode: ColorMode.opacity,
                        scrollable: true,
                        showText: false,
                        textColor: Colors.grey,
                        datasets: {
                          // Updated dates to match current range
                          DateTime(2025, 2, 6): 3,
                          DateTime(2025, 2, 7): 7,
                          DateTime(2025, 2, 10): 10,
                          DateTime(2025, 2, 2): 13,
                          DateTime(2025, 2, 13): 6,
                        },
                        colorsets: const {
                          3: TColors.primaryColor,
                          6: Colors.orange,
                          7: Colors.yellow,
                          10: Colors.green,
                          13: Colors.blue,
                        },
                        startDate: DateTime.now(), // Start from February 2025
                        endDate: DateTime.now().add(Duration(days: 70)), // End in February 2025
                        onClick: (value) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.toString())));
                        },
                      ),
                    ),
                    Container(
                      width: TDevice.getScreenWidth(context), 
                      height: TDevice.getScreenHeight(context)*0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey[700]!)
                      ), 
                      child: Column(children: 
                      [ SizedBox(height: 20),
                        Icon(Iconsax.map, size: 50), 
                      SizedBox(height: 5),
                      Text('To be continued...', 
                      style:Theme.of(context).textTheme.bodyLarge)])
                      )                 
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
