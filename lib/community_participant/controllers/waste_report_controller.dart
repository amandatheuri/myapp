import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class WasteReportController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  
  // Store waste data
  RxInt plasticWaste = 0.obs;
  RxInt glassWaste = 0.obs;
  RxInt paperWaste = 0.obs;
  RxInt totalWaste = 0.obs;

  Future<void> fetchUserWasteData(String userEmail) async {
  try {
    var snapshot = await _db
        .collection('waste_collection')
        .where('userEmail', isEqualTo: userEmail)
        .get();

    if (snapshot.docs.isEmpty) {
      print("⚠ No data found for this user!");
      return;
    }

    int plastic = 0;
    int glass = 0;
    int paper = 0;
    int total = 0;

    for (var doc in snapshot.docs) {
      print("🔹 Document data: ${doc.data()}"); // Debugging step
      plastic += doc['plasticAmount'] as int;
      glass += doc['glassAmount'] as int;
      paper += doc['paperAmount'] as int;
      total += doc['totalAmount'] as int;
    }

    plasticWaste.value = plastic;
    glassWaste.value = glass;
    paperWaste.value = paper;
    totalWaste.value = total;

    print("✅ Data fetched: Plastic=$plastic, Glass=$glass, Paper=$paper, Total=$total");
  } catch (e) {
    print("❌ Error fetching waste data: $e");
  }
}

}
