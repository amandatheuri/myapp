import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/controllers/auth_controller.dart';


  class TokenController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxInt tokenBalance = 0.obs;

  @override
  void onInit() {
    fetchTokenBalance();
    super.onInit();
  }

  Future<void> fetchTokenBalance() async {
    try {
      final userEmail = Get.find<AuthController>().userEmail.value;
      final userQuery = await _firestore
          .collection('Users')
          .where('email', isEqualTo: userEmail)
          .get();

      if (userQuery.docs.isNotEmpty) {
        final userDoc = userQuery.docs.first;
        tokenBalance.value = userDoc['token'] ?? 0;
      }
    } catch (e) {
      print('Failed to fetch token balance: $e');
    }
  }

  Future<void> deductTokens(int tokens) async {
    try {
      final userEmail = Get.find<AuthController>().userEmail.value;
      final userQuery = await _firestore
          .collection('Users')
          .where('email', isEqualTo: userEmail)
          .get();

      if (userQuery.docs.isNotEmpty) {
        final userDoc = userQuery.docs.first;
        final currentTokens = userDoc['token'] ?? 0;
        final newTokens = currentTokens - tokens;

        await userDoc.reference.update({'token': newTokens});
        tokenBalance.value = newTokens;
      }
    } catch (e) {
      print('Failed to deduct tokens: $e');
      throw Exception('Failed to deduct tokens: $e');
    }
  }

  // Fetch user data from Firestore
  // Update the user's token balance
  Future<void> updateTokenBalance(int tokensEarned) async {
    try {
      // Get the current user's ID
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Fetch the current token balance
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        int currentTokens = userDoc['token'] ?? 0;

        // Update the token balance in Firestore
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userId)
            .update({
          'token': currentTokens + tokensEarned,
        });

        // Update the local token balance
        tokenBalance.value = currentTokens + tokensEarned;
      }
    } catch (e) {
      print('Failed to update token balance: $e');
    }
  }
}
