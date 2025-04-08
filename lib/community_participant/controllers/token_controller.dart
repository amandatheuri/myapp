// lib/controllers/token_controller.dart
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TokenController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RxInt tokenBalance = 0.obs;

  @override
  void onInit() {
    fetchTokenBalance();
    super.onInit();
  }

  Future<void> fetchTokenBalance() async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .get();

    if (doc.exists) {
      tokenBalance.value = doc.data()?['token'] ?? 0;
    }
  } catch (e) {
    print('Token balance error: $e');
    Get.snackbar('Error', 'Could not fetch token balance');
  }
}

  Future<bool> deductTokens(int tokens) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return false;

      if (tokenBalance.value < tokens) {
        Get.snackbar('Error', 'Not enough tokens');
        return false;
      }

      await _firestore.runTransaction((transaction) async {
        final doc = await transaction.get(_firestore.collection('Users').doc(user.uid));
        final currentTokens = doc.data()?['token'] ?? 0;
        transaction.update(doc.reference, {'token': currentTokens - tokens});
      });

      tokenBalance.value -= tokens;
      return true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to deduct tokens');
      return false;
    }
  }
}