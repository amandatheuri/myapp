import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepo extends GetxController {
  static AuthRepo instance = Get.find(); // GetX instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(clientId: '24448036818-fmd8e1tn2qcqgmeali9u9ppr2htbukne.apps.googleusercontent.com'); // Google Sign-In instance

  // ✅ Get current user
  User? get currentUser => _auth.currentUser;
  

  // ✅ Signup with Email & Password
  Future<UserCredential?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Signup Error", e.message ?? "Failed to sign up.");
      return null;
    }
  }

  // ✅ Login with Email & Password
  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Login Error", e.message ?? "Failed to log in.");
      return null;
    }
  }

  // ✅ Google Sign-In
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // User canceled the sign-in

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Google Sign-In Error",
          e.message ?? "Failed to sign in with Google.");
      return null;
    } catch (e) {
      Get.snackbar("Error", "Something went wrong during Google Sign-In.");
      return null;
    }
  }

  // ✅ Logout
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut(); // Sign out of Google
    } catch (e) {
      Get.snackbar("Logout Error", "Something went wrong. Please try again.");
    }
  }

  // ✅ Dispose method (optional)
}
