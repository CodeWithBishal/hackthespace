import 'package:flutter/material.dart';
import 'package:innovatika/database/informer_hardware.dart';
import 'package:innovatika/database/informer_plant.dart';
import 'package:innovatika/widget/loading.dart';
import 'package:realm/realm.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ViewDevice extends StatefulWidget {
  final Hardware hardware;
  const ViewDevice({super.key, required this.hardware});

  @override
  State<ViewDevice> createState() => _ViewDeviceState();
}

class _ViewDeviceState extends State<ViewDevice> {
  String _message = "4000";
  String data = "";
  late WebSocketChannel channel;
  @override
  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect('ws://${widget.hardware.ip}');
    channel.stream.listen((data) {
      setState(() {
        _message = data;
      });
    });
  }

  Future<List<PlantInformer>> fetchPlants() async {
    // Open a Realm instance
    var config =
        await Realm.open(Configuration.local(([PlantInformer.schema])));

    // Fetch all users from MongoDB Realm
    var gardenn = config.all<PlantInformer>().toList();
    return gardenn;
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (int.parse(_message) > 0 && int.parse(_message) < 500) {
      data = "Very Wet";
    } else if (int.parse(_message) > 500 && int.parse(_message) < 1200) {
      data = "Moderately Wet";
    } else if (int.parse(_message) > 1200 && int.parse(_message) < 2500) {
      data = "Moist";
    } else if (int.parse(_message) > 2500 && int.parse(_message) < 3800) {
      data = "Dry";
    } else if (int.parse(_message) > 3800) {
      data = "Very Dry";
    }
    return FutureBuilder(
      future: fetchPlants(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return emptyLoading("No Plants found");
        }
        if (snapshot.hasData) {
          var devices = snapshot.data;
          if (devices!.isEmpty) {
            return emptyLoading("No Plants found");
          }
          return ListView.builder(
            itemCount: devices.length,
            itemBuilder: (context, index) {
              if (devices[index].id == widget.hardware.plantAssociated) {
                return ListTile(
                  tileColor: Theme.of(context).colorScheme.surface,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  leading: Image.network(
                    devices[index].image,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    devices[index].name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    _message,
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      data,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              } else {
                return emptyLoading("Not Found!");
              }
            },
          );
        } else {
          return LoadingDeviceAnimation();
        }
      },
    );
  }
}
