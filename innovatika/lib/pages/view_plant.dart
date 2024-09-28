import 'package:flutter/material.dart';
import 'package:innovatika/database/informer_plant.dart';
import 'package:innovatika/widget/appbar.dart';
import 'package:innovatika/widget/loading.dart';
import 'package:realm/realm.dart';

class ViewPlant extends StatefulWidget {
  final RealmList<int> associatedPlant;
  const ViewPlant({
    super.key,
    required this.associatedPlant,
  });

  @override
  State<ViewPlant> createState() => _ViewPlantState();
}

class _ViewPlantState extends State<ViewPlant> {
  Future<List<PlantInformer>> fetchPlants() async {
    // Open a Realm instance
    var config =
        await Realm.open(Configuration.local(([PlantInformer.schema])));

    // Fetch all users from MongoDB Realm
    var gardenn = config.all<PlantInformer>().toList();
    return gardenn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonApp(context: context, title: "View Plants"),
      body: Column(
        children: [
          Divider(),
          Expanded(
            child: FutureBuilder<List<PlantInformer>>(
              future: fetchPlants(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return emptyLoading();
                }
                if (snapshot.hasData) {
                  var devices = snapshot.data;
                  if (devices!.isEmpty) {
                    return emptyLoading();
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var plantData = snapshot.data![index];

                      if (!widget.associatedPlant.contains(plantData.id)) {
                        return Container();
                      }
                      return Column(
                        children: [
                          ListTile(
                            tileColor: Theme.of(context).colorScheme.surface,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            leading: Image.network(
                              plantData.image,
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              plantData.name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              plantData.timeToGrow,
                              style: TextStyle(fontSize: 16),
                            ),
                            trailing: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "${plantData.id} Plants",
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
                return emptyLoading();
              },
            ),
          ),
        ],
      ),
    );
  }
}
