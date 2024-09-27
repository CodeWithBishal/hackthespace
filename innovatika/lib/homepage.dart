import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late bool isOffline = true;
  final tasksListenable = realm.all<Task>().changes.asValueListenable();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Scaffold(),
    );
  }
}
