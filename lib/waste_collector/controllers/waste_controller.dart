import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class WasteController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Reward formula: 1 kg of waste = 10 tokens
  static const int TOKENS_PER_KG = 10;
  
  // Observable variables
  RxInt tokenBalance = 0.obs; // Tracks the user's token balance
  RxList<Map<String, dynamic>> wasteHistory = <Map<String, dynamic>>[].obs; // Tracks waste disposal history
  
  // Fetch the user's token balance
  Future<void> fetchTokenBalance(String userEmail) async {
    try {
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
  
  // Fetch the user's waste disposal history
  Future<void> fetchWasteHistory(String userEmail) async {
    
  try {
    print('Fetching waste history for user: $userEmail');
    
    final wasteQuery = await _firestore
        .collection('waste_collection')
        .where('userEmail', isEqualTo: userEmail)
        .orderBy('timestamp', descending: true)
        .get();
 
    print('Total documents found: ${wasteQuery.docs.length}');

    wasteHistory.value = wasteQuery.docs.map((doc) {
      Map<String, dynamic> data = Map<String, dynamic>.from(doc.data());
      data['id'] = doc.id;
      print('Waste entry: ${data.toString()}');
      return data;
    }).toList();
   

    print('Fetched ${wasteHistory.length} waste history records for $userEmail');
  } catch (e) {
    print('Failed to fetch waste history: $e');
  }
}
  
  // Save waste data and reward tokens
  Future<void> saveWasteData({
  required String userEmail,
  required double plasticAmount,
  required double glassAmount,
  required double paperAmount,
  required double totalAmount,
}) async {
  try {
    // Save waste data to Firestore
    final docRef = await _firestore.collection('waste_collection').add({
      'glassAmount': glassAmount,
        'paperAmount': paperAmount,
        'plasticAmount': plasticAmount,
        'timestamp': FieldValue.serverTimestamp(),
        'totalAmount': totalAmount,
        'userEmail': userEmail,
    });

    // Fetch the newly added document
    final docSnapshot = await docRef.get();
    final newEntry = docSnapshot.data() as Map<String, dynamic>;

    // Update the wasteHistory list
    wasteHistory.add(newEntry);

    // Calculate tokens earned
    int tokensEarned = (totalAmount * TOKENS_PER_KG).toInt();

    // Update the user's token balance in Firestore
    await _updateUserTokens(userEmail, tokensEarned);

    print('Waste data saved and $tokensEarned tokens awarded to $userEmail');
  } catch (e) {
    print('Failed to save waste data: $e');
    throw Exception('Failed to save waste data: $e');
  }
}
 // Update the user's token balance
Future<void> _updateUserTokens(String userEmail, int tokensEarned) async {
  try {
    print('Updating token balance for $userEmail...');
    
    // Try different approaches to find the user document
    var userQuery = await _firestore
        .collection('Users')
        .where('email', isEqualTo: userEmail)
        .get();
    
    // If not found, try case-insensitive search (lowercase)
    if (userQuery.docs.isEmpty) {
      print('Trying case-insensitive search with lowercase email...');
      userQuery = await _firestore
          .collection('Users')
          .where('email', isEqualTo: userEmail.toLowerCase())
          .get();
    }
    
    // If still not found, try alternative field names
    if (userQuery.docs.isEmpty) {
      print('Trying alternative field names...');
      
      // Try to find by uid if there's a match with email as substring
      final allUsers = await _firestore.collection('Users').get();
      final potentialMatches = allUsers.docs.where((doc) {
        final data = doc.data();
        // Check various possible field names
        return (data['email']?.toString().toLowerCase() == userEmail.toLowerCase()) ||
               (data['userEmail']?.toString().toLowerCase() == userEmail.toLowerCase()) ||
               (data['user_email']?.toString().toLowerCase() == userEmail.toLowerCase()) ||
               (data['Email']?.toString().toLowerCase() == userEmail.toLowerCase());
      }).toList();
      
      if (potentialMatches.isNotEmpty) {
        // Use the first matching document
        final userDoc = potentialMatches.first;
        final currentTokens = userDoc['token'] ?? 0;
        
        await userDoc.reference.update({
          'token': currentTokens + tokensEarned,
        });
        
        // Update the local token balance
        tokenBalance.value = currentTokens + tokensEarned;
        
        print('Updated token balance for match: $currentTokens -> ${currentTokens + tokensEarned}');
        return;
      }
      
      // Last resort: print all user emails to debug
      print('Available users in database:');
      for (var doc in allUsers.docs) {
        print('User doc: ${doc.data()}');
      }
      
      // If we get here, the user truly wasn't found
      print('User not found in Firestore: $userEmail');
      throw Exception('User not found. Please check if the email exists in the database');
    }
    
    // User found, proceed with token update
    final userDoc = userQuery.docs.first;
    final currentTokens = userDoc['token'] ?? 0;
    
    // Update the token balance
    await userDoc.reference.update({
      'token': currentTokens + tokensEarned,
    });
    
    // Update the local token balance
    tokenBalance.value = currentTokens + tokensEarned;
    
    print('Updated token balance for $userEmail: $currentTokens -> ${currentTokens + tokensEarned}');
  } catch (e) {
    print('Failed to update user tokens: $e');
    throw Exception('Failed to update user tokens: $e');
  }
} 
}