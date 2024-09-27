import 'package:flutter/material.dart';
import 'package:innovatika/database/informer.dart';

 class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late bool isOffline = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: uiUpdateHardware(isOffline),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data ?? Container();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
