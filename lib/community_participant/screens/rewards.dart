import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:myapp/community_participant/controllers/token_controller.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  _RewardStorePageState createState() => _RewardStorePageState();
}

class _RewardStorePageState extends State<RewardsScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  final List<String> stores = [
    "Safaricom",
    "Green Grocers",
    "Recycle Hub",
    "Sustainable Living",
    "EcoWear",
  ];
  List<String> filteredStores = [];

  @override
  void initState() {
    super.initState();
    filteredStores = stores;
  }

  void _filterStores(String query) {
    setState(() {
      filteredStores = stores
          .where((store) => store.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Search stores...",
                  border: InputBorder.none,
                ),
                onChanged: _filterStores,
              )
            : Text("Rewards Store"),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Iconsax.search_normal),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  filteredStores = stores;
                }
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          itemCount: filteredStores.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Get.to(StorePage(storeName: filteredStores[index])),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Iconsax.shop, size: 50, color: Colors.green),
                    SizedBox(height: 10),
                    Text(
                      filteredStores[index],
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class StorePage extends StatelessWidget {
  final String storeName;
  const StorePage({required this.storeName, super.key});

  @override
  Widget build(BuildContext context) {
    final TokenController tokenController = Get.find();

    // Example products for each store
    final Map<String, List<Map<String, dynamic>>> storeProducts = {
      "Safaricom": [
        {"name": "100 MB Data", "tokens": 50},
        {"name": "500 MB Data", "tokens": 100},
        {"name": "1 GB Data", "tokens": 200},
      ],
      "Green Grocers": [
        {"name": "Organic Vegetables", "tokens": 150},
        {"name": "Fresh Fruits", "tokens": 100},
        {"name": "Eco-Friendly Bag", "tokens": 50},
      ],
      "Recycle Hub": [
        {"name": "Reusable Water Bottle", "tokens": 200},
        {"name": "Recycled Notebook", "tokens": 100},
        {"name": "Eco Tote Bag", "tokens": 150},
      ],
      "Sustainable Living": [
        {"name": "Bamboo Toothbrush", "tokens": 50},
        {"name": "Reusable Straw Set", "tokens": 100},
        {"name": "Solar Charger", "tokens": 300},
      ],
      "EcoWear": [
        {"name": "Organic Cotton T-Shirt", "tokens": 250},
        {"name": "Recycled Jeans", "tokens": 400},
        {"name": "Eco-Friendly Sneakers", "tokens": 500},
      ],
    };

    final List<Map<String, dynamic>> products = storeProducts[storeName] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text(storeName)),
      body: Column(
        children: [
          // Display user's token balance
          Obx(() => Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Your Tokens:",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${tokenController.tokenBalance.value}",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ],
                ),
              )),
          // List of products
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    title: Text(product["name"]),
                    subtitle: Text("${product["tokens"]} tokens"),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Redeem product
                        if (tokenController.tokenBalance.value >= product["tokens"]) {
                          tokenController.deductTokens(product["tokens"]);
                          Get.snackbar(
                            "Success",
                            "You have redeemed ${product["name"]}",
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                          );
                        } else {
                          Get.snackbar(
                            "Error",
                            "Not enough tokens to redeem ${product["name"]}",
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }
                      },
                      child: Text("Redeem"),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}