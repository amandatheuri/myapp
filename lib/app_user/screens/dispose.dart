import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/core/utils/constants/colors.dart';
import 'package:myapp/core/utils/constants/imagestrings.dart';

class DisposePage extends StatelessWidget {
  DisposePage({super.key});

  // Dummy list of waste collection centers
  final List<Map<String, String>> collectionCenters = [
    {"name": "Green Recycling Center", "location": "Nairobi CBD"},
    {"name": "Westlands Eco-Point", "location": "Westlands"},
    {"name": "South B Waste Hub", "location": "South B"},
  ];

  // Waste Categories & Sample Items
  final List<Map<String, dynamic>> wasteCategories = [
    {
      "title": "Plastic",
      "image": TImageStrings.plastic,
      "items": [
        "Water bottles",
        "Plastic bags",
        "Food containers",
        "Straws",
        "Disposable cutlery"
      ]
    },
    {
      "title": "Glass",
      "image": TImageStrings.glass,
      "items": [
        "Glass bottles",
        "Broken glass",
        "Mirrors",
        "Glass jars",
        "Windows (without frames)"
      ]
    },
    {
      "title": "Paper",
      "image": TImageStrings.paper,
      "items": [
        "Newspapers",
        "Cardboard",
        "Magazines",
        "Office paper",
        "Paper bags"
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Waste Disposal Guide")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// **Waste Collection Centers**
              const Text(
                "Find a Waste Collection Center Near You:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: collectionCenters.length,
                itemBuilder: (context, index) {
                  final center = collectionCenters[index];

                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.location_on,
                          color: TColors.primaryColor),
                      title: Text(center["name"]!,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(center["location"]!),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Get.snackbar("Collection Center Selected",
                            "You selected ${center["name"]}");
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              /// **Waste Segregation Guide**
              const Text(
                "Tap on a category to see recyclable items:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Two items per row
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: wasteCategories.length,
                itemBuilder: (context, index) {
                  final category = wasteCategories[index];

                  return GestureDetector(
                    onTap: () {
                      Get.dialog(
                        AlertDialog(
                          title: Text("${category["title"]} Waste"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: (category["items"] as List<String>)
                                .map((item) => Text("• $item"))
                                .toList(),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(),
                              child: const Text("Close",
                                  style:
                                      TextStyle(color: TColors.primaryColor)),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Card(
                      elevation: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            category["image"]!,
                            height: 80,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            category["title"]!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
