import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthRepo extends GetxController {
  static AuthRepo instance = Get.find(); // GetX instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ✅ Get current user
  User? get currentUser => _auth.currentUser;

  // ✅ Signup with Email & Password
  Future<UserCredential?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Signup Error", e.message ?? "Failed to sign up.");
      return null;
    }
  }

  // ✅ Login with Email & Password
  Future<UserCredential?> signInWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Login Error", e.message ?? "Failed to log in.");
      return null;
    }
  }

  // ✅ Logout
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      Get.snackbar("Logout Error", "Something went wrong. Please try again.");
    }
  }
}
