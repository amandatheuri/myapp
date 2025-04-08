import 'package:cloud_firestore/cloud_firestore.dart';
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
  final List<String> stores = []; // Now loaded from Firestore
  List<String> filteredStores = [];
  final TokenController tokenController = Get.find();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadStores();
  }

  Future<void> _loadStores() async {
    final snapshot = await _firestore.collection('reward_stores').get();
    setState(() {
      stores.clear();
      stores.addAll(snapshot.docs.map((doc) => doc['name'] as String));
      filteredStores = List.from(stores);
    });
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
            : Obx(() => Row(
                  children: [
                    Text("Rewards Store"),
                    Spacer(),
                    Chip(
                      label: Text(
                        "${tokenController.tokenBalance.value} Tokens",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.green,
                    ),
                  ],
                )),
        actions: [
          if (!_isSearching)
            IconButton(
              icon: Icon(Iconsax.search_normal),
              onPressed: () {
                setState(() {
                  _isSearching = true;
                });
              },
            )
          else
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                setState(() {
                  _isSearching = false;
                  _searchController.clear();
                  filteredStores = List.from(stores);
                });
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: stores.isEmpty
            ? Center(child: CircularProgressIndicator())
            : GridView.builder(
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
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.black),
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

  Future<void> _redeemProduct(Map<String, dynamic> product, TokenController tokenController) async {
    if (tokenController.tokenBalance.value >= product['tokens']) {
      final success = await tokenController.deductTokens(product['tokens']);
      if (success) {
        Get.snackbar(
          "Success",
          "You redeemed ${product['name']}",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "Not enough tokens",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokenController = Get.find<TokenController>();

    return Scaffold(
      appBar: AppBar(title: Text(storeName)),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('reward_stores')
            .where('name', isEqualTo: storeName)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          if (snapshot.data!.docs.isEmpty) return Center(child: Text('Store not found'));
          
          final storeData = snapshot.data!.docs.first.data() as Map<String, dynamic>;
          final products = storeData['products'] as List<dynamic>? ?? [];
          
          return Column(
            children: [
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
                    Text("Your Tokens:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("${tokenController.tokenBalance.value}", 
                        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                  ],
                ),
              )),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index] as Map<String, dynamic>;
                    return Obx(() => Card(
                      margin: EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        leading: Icon(Icons.shopping_bag, color: Colors.green),
                        title: Text(product['name']),
                        subtitle: Text("${product['tokens']} tokens"),
                        trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: tokenController.tokenBalance.value >= product['tokens']
                                ? Colors.green
                                : Colors.grey,
                          ),
                          onPressed: () => _redeemProduct(product, tokenController),
                          child: Text("Redeem", style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ));
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}