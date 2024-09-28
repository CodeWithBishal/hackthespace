import 'package:flutter/material.dart';
import 'package:innovatika/database/informer_garden.dart';
import 'package:innovatika/pages/view_plant.dart';
import 'package:innovatika/widget/loading.dart';
import 'package:realm/realm.dart';

class Gardens extends StatefulWidget {
  const Gardens({super.key});

  @override
  State<Gardens> createState() => _GardensState();
}

class _GardensState extends State<Gardens> {
  Future<List<GardenInformer>> fetchDevices() async {
    // Open a Realm instance
    var config =
        await Realm.open(Configuration.local(([GardenInformer.schema])));

    // Fetch all users from MongoDB Realm
    var gardenn = config.all<GardenInformer>().toList();
    return gardenn;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(),
        Expanded(
          child: FutureBuilder<List<GardenInformer>>(
            future: fetchDevices(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return emptyLoading("No Garden found");
              }
              if (snapshot.hasData) {
                var devices = snapshot.data;
                if (devices!.isEmpty) {
                  return emptyLoading("No Garden found");
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var garData = snapshot.data![index];
                    return Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewPlant(
                                  associatedPlant: garData.plantAssoc,
                                ),
                              ),
                            );
                          },
                          tileColor: Theme.of(context).colorScheme.surface,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 20.0),
                          leading: Image.network(
                            garData.imgURL,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            "Garden ${garData.id + 1}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            garData.dateTime,
                            style: TextStyle(fontSize: 16),
                          ),
                          trailing: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "${garData.plantAssoc.length} Plants",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Divider()
                      ],
                    );
                  },
                );
              }
              return LoadingDeviceAnimation();
            },
          ),
        ),
      ],
    );
  }
}
