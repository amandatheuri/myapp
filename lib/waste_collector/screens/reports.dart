import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/waste_collector/controllers/waste_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WasteCollectorReportsPage extends StatelessWidget {
  final WasteController _wasteController = Get.find();

  WasteCollectorReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Key Metrics Section
            _buildKeyMetricsSection(),
            SizedBox(height: 20),
            // Waste Collection Trends Chart
            _buildWasteTrendsChart(),
            SizedBox(height: 20),
            // Top Contributors Section
            _buildTopContributorsSection(),
            SizedBox(height: 20),
            // Recent Waste Submissions Table
            _buildRecentSubmissionsTable(),
          ],
        ),
      ),
    );
  }

  // Key Metrics Section
  Widget _buildKeyMetricsSection() {
    return Obx(() {
      double totalWaste = _wasteController.wasteHistory
          .fold(0, (sum, entry) => sum + (entry['totalAmount'] ?? 0));
      int totalTokens = (totalWaste * WasteController.TOKENS_PER_KG).toInt();
      double averageWaste = totalWaste / _wasteController.wasteHistory.length;

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMetricCard('Total Waste', '${totalWaste.toStringAsFixed(1)} kg',
              Colors.blue),
          _buildMetricCard('Total Tokens', '$totalTokens', Colors.green),
          _buildMetricCard('Avg Waste', '${averageWaste.toStringAsFixed(1)} kg',
              Colors.orange),
        ],
      );
    });
  }

  // Metric Card Widget
  Widget _buildMetricCard(String title, String value, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(title,
                style: TextStyle(fontSize: 16, color: Colors.grey[700])),
            SizedBox(height: 8),
            Text(value,
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }

  // Waste Collection Trends Chart
  Widget _buildWasteTrendsChart() {
    return Obx(() {
      // Group waste data by date
      Map<DateTime, double> wasteByDate = {};
      for (var entry in _wasteController.wasteHistory) {
        DateTime date = (entry['timestamp'] as Timestamp).toDate();
        date = DateTime(date.year, date.month, date.day); // Normalize to day
        wasteByDate[date] =
            (wasteByDate[date] ?? 0) + (entry['totalAmount'] ?? 0);
      }

      // Convert to a list of chart data points
      List<ChartData> chartData = wasteByDate.entries.map((entry) {
        return ChartData(entry.key, entry.value);
      }).toList();

      return SizedBox(
        height: 300,
        child: SfCartesianChart(
          primaryXAxis: DateTimeAxis(),
          series: <CartesianSeries>[
            LineSeries<ChartData, DateTime>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.date,
              yValueMapper: (ChartData data, _) => data.amount,
              color: Colors.green,
            ),
          ],
        ),
      );
    });
  }

  // Top Contributors Section
  Widget _buildTopContributorsSection() {
    return Obx(() {
      // Group waste data by user
      Map<String, double> wasteByUser = {};
      for (var entry in _wasteController.wasteHistory) {
        String userEmail = entry['userEmail'];
        wasteByUser[userEmail] =
            (wasteByUser[userEmail] ?? 0) + (entry['totalAmount'] ?? 0);
      }

      // Sort users by total waste
      var sortedUsers = wasteByUser.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Top Contributors',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          ...sortedUsers.take(5).map((entry) {
            return ListTile(
              title: Text(entry.key),
              trailing: Text('${entry.value.toStringAsFixed(1)} kg'),
            );
          }),
        ],
      );
    });
  }

  // Recent Waste Submissions Table
  Widget _buildRecentSubmissionsTable() {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recent Submissions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text('User')),
                DataColumn(label: Text('Plastic (kg)')),
                DataColumn(label: Text('Glass (kg)')),
                DataColumn(label: Text('Paper (kg)')),
                DataColumn(label: Text('Total (kg)')),
              ],
              rows: _wasteController.wasteHistory.take(5).map((entry) {
                return DataRow(cells: [
                  DataCell(Text(entry['userEmail'])),
                  DataCell(Text(entry['plasticAmount'].toStringAsFixed(1))),
                  DataCell(Text(entry['glassAmount'].toStringAsFixed(1))),
                  DataCell(Text(entry['paperAmount'].toStringAsFixed(1))),
                  DataCell(Text(entry['totalAmount'].toStringAsFixed(1))),
                ]);
              }).toList(),
            ),
          ),
        ],
      );
    });
  }
}

// Chart Data Model
class ChartData {
  final DateTime date;
  final double amount;

  ChartData(this.date, this.amount);
}
