import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controllers/waste_report_controller.dart';

class WasteCategoryReport extends StatelessWidget {
  final String userEmail;
  WasteCategoryReport({required this.userEmail});

  @override
  Widget build(BuildContext context) {
    final WasteReportController controller = Get.put(WasteReportController());

    // Fetch data when the screen loads
    controller.fetchUserWasteData(userEmail);

    return Scaffold(
      appBar: AppBar(title: Text("Waste Category Insights")),
      body: Center(
        child: Obx(() {
          if (controller.totalWaste.value == 0) {
            return Text("No waste data available.");
          }
          
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 300,
                child: PieChart(
                  PieChartData(
                    sections: [
                      _buildPieChartSection("Plastic", Colors.blue, controller.plasticWaste.value, controller.totalWaste.value),
                      _buildPieChartSection("Glass", Colors.green, controller.glassWaste.value, controller.totalWaste.value),
                      _buildPieChartSection("Paper", Colors.orange, controller.paperWaste.value, controller.totalWaste.value),
                    ],
                    sectionsSpace: 2,
                    centerSpaceRadius: 40,
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildLegend(),
            ],
          );
        }),
      ),
    );
  }

  // Helper function to create pie chart sections
  PieChartSectionData _buildPieChartSection(String label, Color color, int value, int total) {
    double percentage = (total == 0) ? 0 : (value / total) * 100;
    return PieChartSectionData(
      color: color,
      value: value.toDouble(),
      title: "${percentage.toStringAsFixed(1)}%",
      radius: 50,
      titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  // Legend for the chart
  Widget _buildLegend() {
    return Column(
      children: [
        _legendItem("Plastic", Colors.blue),
        _legendItem("Glass", Colors.green),
        _legendItem("Paper", Colors.orange),
      ],
    );
  }

  Widget _legendItem(String label, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: 12, height: 12, color: color),
        SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}
