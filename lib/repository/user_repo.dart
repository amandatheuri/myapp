import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:myapp/models/usermodel.dart';

class UserRepo extends GetxController {
  static UserRepo instance = Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUserCredentials(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.uid).set(user.toMap());
    } catch (e) {
      Get.snackbar("Error", "Failed to save user credentials: $e");
      throw Exception("Failed to save user: $e");
    }
  }
}
