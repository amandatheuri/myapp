import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {  // Changed to GetxService
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _currentAdmin;

  User? get currentUser => _currentAdmin;

  // Proper initialization with async operations
  @override
  Future<void> onInit() async {
    await initialize();
    super.onInit();
  }

  Future<void> initialize() async {
    try {
      debugPrint('🔐 Initializing AuthService...');
      
      // 1. Check for cached user session
      _currentAdmin = _auth.currentUser;
      
      if (_currentAdmin != null) {
        // 2. Verify if the cached user is still a valid admin
        final adminDoc = await _firestore
            .collection('admin')
            .doc(_currentAdmin!.uid)
            .get()
            .timeout(Duration(seconds: 3));
            
        if (!adminDoc.exists || adminDoc['isSuperAdmin'] != true) {
          await _auth.signOut();
          _currentAdmin = null;
        }
      }
      
      debugPrint('✅ AuthService initialized. Admin: $_currentAdmin');
    } catch (e) {
      debugPrint('❌ AuthService init error: $e');
      rethrow;
    }
  }

  Future<User?> loginAdmin(String email, String password) async {
    try {
      // 1. Authenticate
      UserCredential cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ).timeout(Duration(seconds: 10));

      // 2. Verify admin status
      DocumentSnapshot adminDoc = await _firestore
          .collection('admins')  
          .doc(cred.user!.uid)
          .get()
          .timeout(Duration(seconds: 5));

      if (adminDoc.exists && adminDoc['isSuperAdmin'] == true) {
        _currentAdmin = cred.user;
        return _currentAdmin;
      } else {
        await _auth.signOut(); 
        throw Exception('Access denied. Not the registered admin.');
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Login failed');
    } on TimeoutException {
      throw Exception('Connection timeout. Please try again.');
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _currentAdmin = null;
  }
}