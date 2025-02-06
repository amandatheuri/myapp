import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({super.key});

  @override
  _ChallengesPageState createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesScreen> {
  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> challenges = [
    {"title": "Recycle 5 Plastic Bottles", "progress": 3, "goal": 5},
    {"title": "Compost Organic Waste", "progress": 2, "goal": 5},
    {"title": "Reduce Single-Use Plastic", "progress": 4, "goal": 4},
    {"title": "Join a Cleanup Event", "progress": 1, "goal": 3},
  ];
  List<Map<String, dynamic>> filteredChallenges = [];

  @override
  void initState() {
    super.initState();
    filteredChallenges = challenges;
  }

  void _filterChallenges(String query) {
    setState(() {
      filteredChallenges = challenges
          .where((challenge) => challenge["title"].toLowerCase().contains(query.toLowerCase()))
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
                  hintText: "Search challenges...",
                  border: InputBorder.none,
                ),
                onChanged: _filterChallenges,
              )
            : Text("Challenges"),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Iconsax.search_normal),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  filteredChallenges = challenges;
                }
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: filteredChallenges.length,
          itemBuilder: (context, index) {
            var challenge = filteredChallenges[index];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text(
                  challenge["title"],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    LinearProgressIndicator(
                      value: challenge["progress"] / challenge["goal"],
                      minHeight: 8,
                      backgroundColor: Colors.grey[300],
                      color: Colors.green,
                    ),
                    SizedBox(height: 5),
                    Text("${challenge["progress"]} / ${challenge["goal"]} completed"),
                  ],
                ),
                trailing: Icon(Iconsax.award, color: Colors.amber),
              ),
            );
          },
        ),
      ),
    );
  }
}
