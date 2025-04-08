import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WasteController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  static const int TOKENS_PER_KG = 10;
  
  RxInt tokenBalance = 0.obs;
  RxList<Map<String, dynamic>> wasteHistory = <Map<String, dynamic>>[].obs;
  RxDouble todayWaste = 0.0.obs;
  RxDouble lifetimeWaste = 0.0.obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    fetchWasteData();
    super.onInit();
  }

  Future<void> fetchWasteData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final user = _auth.currentUser;
      if (user == null) {
        errorMessage.value = 'No user logged in';
        return;
      }

      // First get token balance
      await _fetchTokenBalance(user.uid);
      
      // Then get waste history
      await fetchWasteHistory();
      
      // Finally calculate totals
      await _calculateTodayWaste();
      await _calculateLifetimeWaste();

      print('Data loaded successfully');
      print('Token balance: ${tokenBalance.value}');
      print('Waste records: ${wasteHistory.length}');
      print('Lifetime waste: ${lifetimeWaste.value}kg');
    } catch (e) {
      errorMessage.value = 'Failed to load data: ${e.toString()}';
      print('Error: $e');
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _fetchTokenBalance(String userId) async {
    try {
      final doc = await _firestore
          .collection('Users')
          .doc(userId)
          .get();

      if (!doc.exists) {
        throw Exception('User document not found');
      }

      tokenBalance.value = (doc.data()?['token'] as num?)?.toInt() ?? 0;
    } catch (e) {
      print('Token balance error: $e');
      rethrow;
    }
  }

  Future<void> fetchWasteHistory() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      final query = await _firestore
          .collection('waste_collection')
          .where('userId', isEqualTo: user.uid)
          .orderBy('timestamp', descending: true)
          .get();

      wasteHistory.value = query.docs.map((doc) {
        final data = doc.data();
        return {
          ...data,
          'id': doc.id,
          'timestamp': data['timestamp']?.toDate(),
          'totalAmount': (data['totalAmount'] as num?)?.toDouble() ?? 0.0,
        };
      }).toList();
    } catch (e) {
      print('Waste history error: $e');
      rethrow;
    }
  }

  Future<void> _calculateLifetimeWaste() async {
    try {
      lifetimeWaste.value = wasteHistory.fold(
        0.0,
        (sum, entry) => sum + (entry['totalAmount'] as double),
      );
    } catch (e) {
      print('Lifetime waste calculation error: $e');
      lifetimeWaste.value = 0.0;
    }
  }

  Future<void> _calculateTodayWaste() async {
    try {
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      todayWaste.value = wasteHistory.where((entry) {
        final timestamp = entry['timestamp'] as DateTime?;
        if (timestamp == null) return false;
        final entryDate = DateFormat('yyyy-MM-dd').format(timestamp);
        return entryDate == today;
      }).fold(0.0, (sum, entry) => sum + (entry['totalAmount'] as double));
    } catch (e) {
      print('Today waste calculation error: $e');
      todayWaste.value = 0.0;
    }
  }

  Future<void> saveWasteData({
    required String userEmail,
    required double totalAmount,
    required Map<String, double> wasteTypes,
    required double glassAmount,
    required double plasticAmount,
    required double paperAmount,
  }) async {
    try {
      isLoading.value = true;
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('No user logged in');
      }

      // 1. Save waste entry
      final docRef = await _firestore.collection('waste_collection').add({
        ...wasteTypes,
        'timestamp': FieldValue.serverTimestamp(),
        'totalAmount': totalAmount,
        'userEmail': userEmail,
        'userId': user.uid, // Critical for querying
      });

      // 2. Update local state
      final newEntry = (await docRef.get()).data()!;
      wasteHistory.insert(0, {
        ...newEntry,
        'timestamp': newEntry['timestamp']?.toDate(),
        'totalAmount': (newEntry['totalAmount'] as num).toDouble(),
      });
      
      // 3. Update waste totals
      lifetimeWaste.value += totalAmount;
      todayWaste.value += totalAmount;

      // 4. Award tokens
      final tokensEarned = (totalAmount * TOKENS_PER_KG).toInt();
      await _updateTokenBalance(user.uid, tokensEarned);

      Get.snackbar('Success', 'Added ${totalAmount}kg waste (+$tokensEarned tokens)');
    } catch (e) {
      Get.snackbar('Error', 'Failed to save waste data: ${e.toString()}');
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _updateTokenBalance(String userId, int tokens) async {
    try {
      await _firestore
          .collection('Users')
          .doc(userId)
          .update({
            'token': FieldValue.increment(tokens),
          });

      tokenBalance.value += tokens;
    } catch (e) {
      print('Token update error: $e');
      rethrow;
    }
  }

  Future<void> init() async {}
}