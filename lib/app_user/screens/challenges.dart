import 'package:flutter/material.dart';

class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({super.key});
  @override
  _ChallengesScreenPageState createState() => _ChallengesScreenPageState();
}

class _ChallengesScreenPageState extends State<ChallengesScreen> {
  int counter = 0;

  @override
  initState() {
    super.initState();
  }

  void increment() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(
            child: ElevatedButton(
                onPressed: () {
                  increment();
                },
                child: Text('Counter: $counter'))),
      ),
    );
  }
}
