import 'package:cloud_firestore/cloud_firestore.dart';

class WasteRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Save waste collection data to Firestore
  Future<void> saveWasteData({
    required String userEmail,
    required double plasticAmount,
    required double glassAmount,
    required double paperAmount,
    required double totalAmount,
  }) async {
    try {
      await _firestore.collection('waste_collection').add({
        'glassAmount': glassAmount,
        'paperAmount': paperAmount,
        'plasticAmount': plasticAmount,
        'timestamp': FieldValue.serverTimestamp(),
        'totalAmount': totalAmount,
        'userEmail': userEmail,
      });
    } catch (e) {
      print('Failed to save waste data: $e');
      throw Exception('Failed to save waste data: $e');
    }
  }

  // Fetch waste collection data from Firestore
  Stream<QuerySnapshot> getWasteData() {
    return _firestore.collection('waste_collection').snapshots();
  }
}
