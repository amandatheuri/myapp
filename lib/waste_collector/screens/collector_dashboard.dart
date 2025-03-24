import 'package:flutter/material.dart';
import 'package:myapp/waste_collector/screens/home.dart';
import 'package:myapp/waste_collector/screens/reports.dart';
import 'package:myapp/waste_collector/screens/settings.dart';

class WasteCollectorDashboard extends StatefulWidget {
  const WasteCollectorDashboard({super.key});

  @override
  _WasteCollectorDashboardState createState() =>
      _WasteCollectorDashboardState();
}

class _WasteCollectorDashboardState extends State<WasteCollectorDashboard> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    WasteCollectorReportsPage(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Waste Collector Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              //logout functionality
            },
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: 'Reports'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
