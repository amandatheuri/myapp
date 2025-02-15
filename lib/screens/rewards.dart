import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  _RewardStorePageState createState() => _RewardStorePageState();
}

class _RewardStorePageState extends State<RewardsScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  final List<String> stores = [
    "EcoMart",
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
    return Scaffold(
      appBar: AppBar(title: Text(storeName)),
      body: Center(child: Text("Welcome to $storeName!")),
    );
  }
}
