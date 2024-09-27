import 'package:flutter/material.dart';

class updateDb extends StatefulWidget {
  const updateDb({super.key});

  @override
  State<updateDb> createState() => _updateDbState();
}

class _updateDbState extends State<updateDb> {
  late String name;
  late String ip;
  late String ssid;
  late String passwd;
  late List<int> gardenIDAssco;
  // String text = "No Value Entered";

  void updateData() {
    print(name);
    print(ip);
    print(ssid);
    print(passwd);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Update"),
        ),
        body: Center(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(hintText: "Enter Name"),
                onChanged: (value) {
                  name = value;
                },
              ),
              TextField(
                decoration: InputDecoration(hintText: "Enter IP"),
                onChanged: (value) {
                  ip = value;
                },
              ),
              TextField(
                decoration: InputDecoration(hintText: "Enter SSID"),
                onChanged: (value) {
                  ssid = value;
                },
              ),
              TextField(
                decoration: InputDecoration(hintText: "Enter Password"),
                onChanged: (value) {
                  passwd = value;
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    updateData();
                  },
                  child: Text("Update"))
            ],
          ),
        ),
      ),
    );
  }
}
