// auth_controller.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:myapp/superadmin/screens/superadmin_screen.dart';
import 'package:myapp/waste_collector/screens/home.dart';

class AdminAuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Regular user login
  Future<void> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed('/user-dashboard');
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Login failed');
    }
  }

  // Admin role login
  Future<void> loginAdmin(String email, String password, String role) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Verify admin role
      final adminDoc = await _firestore.collection('admins')
        .doc(credential.user!.uid)
        .get();

      if (!adminDoc.exists || adminDoc.data()?['role'] != role) {
        await _auth.signOut();
        throw Exception('Invalid permissions for $role access');
      }

      // Redirect to appropriate dashboard
      switch (role) {
        case 'superadmin':
          Get.offAll(() => SuperAdminDashboard());
          break;
        case 'collector':
          Get.offAll(()=> HomeScreen());
          break;
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Admin login failed');
    }
  }
}