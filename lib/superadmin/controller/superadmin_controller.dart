import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Reactive variables
  var stores = <Map<String, dynamic>>[].obs;
  var collectors = <Map<String, dynamic>>[].obs;
  var topStores = <Map<String, dynamic>>[].obs;
  var stats = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    await fetchStores();
    await fetchCollectors();
    await fetchStats();
    await fetchTopStores();
  }

  // Store Management
  Future<void> addStore(String name) async {
    await _firestore.collection('reward_stores').add({
      'name': name,
      'createdAt': FieldValue.serverTimestamp(),
      'isActive': true,
    });
    await fetchStores();
  }

  Future<void> fetchStores() async {
    final snapshot = await _firestore.collection('reward_stores').get();
    stores.value = snapshot.docs.map((doc) => {
      ...doc.data(),
      'id': doc.id,
    }).toList();
  }

  Future<void> deleteStore(String id) async {
    await _firestore.collection('reward_stores').doc(id).delete();
    stores.removeWhere((store) => store['id'] == id);
  }

  // Collector Management
  Future<void> addCollector(String name) async {
    final collectorId = 'WC-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}';
    await _firestore.collection('collectors').doc(collectorId).set({
      'name': name,
      'collectorId': collectorId,
      'createdAt': FieldValue.serverTimestamp(),
      'isActive': true,
      'authKey': _generateAuthKey(),
    });
    await fetchCollectors();
  }

  String _generateAuthKey() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    return List.generate(6, (index) => chars[Random().nextInt(chars.length)]).join();
  }

  Future<void> fetchCollectors() async {
    final snapshot = await _firestore.collection('collectors').get();
    collectors.value = snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<void> deleteCollector(String id) async {
    await _firestore.collection('collectors').doc(id).delete();
    collectors.removeWhere((collector) => collector['collectorId'] == id);
  }

  // Analytics
  Future<void> fetchStats() async {
    final waste = await _firestore.collection('waste_collection').get();
    final users = await _firestore.collection('Users').get();
    
    stats.value = {
      'totalWaste': waste.docs.fold(0.0, (sum, doc) => sum + (doc.data()['totalAmount'] ?? 0.0)),
      'totalUsers': users.size,
      'totalCollectors': collectors.length,
      'activeStores': stores.where((s) => s['isActive'] == true).length,
    };
  }

  Future<void> fetchTopStores() async {
    final snapshot = await _firestore.collection('reward_stores')
      .orderBy('redemptions', descending: true)
      .limit(5)
      .get();
    topStores.value = snapshot.docs.map((doc) => doc.data()).toList();
  }

  // Report Generation
  Future<void> generateReport() async {
    try {
      await fetchStats();
      await fetchTopStores();
      
      final reportData = '''
        SUPER ADMIN REPORT
        Date: ${DateTime.now().toString()}
        
        SUMMARY STATISTICS:
        - Total Users: ${stats['totalUsers']}
        - Total Waste Collected: ${stats['totalWaste']} kg
        - Active Collectors: ${stats['totalCollectors']}
        - Active Stores: ${stats['activeStores']}
        
        TOP PERFORMING STORES:
        ${topStores.map((store) => '- ${store['name']}: ${store['redemptions']} redemptions').join('\n')}
      ''';

      // Implement your report sharing logic here
      print(reportData); // Replace with actual sharing code
      Get.snackbar('Success', 'Report generated');
      
    } catch (e) {
      Get.snackbar('Error', 'Failed to generate report: $e');
    }
  }

  void logout() {
    // Implement your logout logic
    Get.offAllNamed('/login');
  }
}