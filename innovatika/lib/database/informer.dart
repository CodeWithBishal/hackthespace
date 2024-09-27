import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:realm/realm.dart';

part 'informer.realm.dart';

@RealmModel()
class _Hardware {
  @PrimaryKey()
  @MapTo('_idH')
  late int id;
  late String name;
  late String ip;
  late String ssid;
  late String passwd;
  late List<int> gardenAssoc;
}

@RealmModel()
class _GardenInformer {
  @PrimaryKey()
  @MapTo('_idG')
  late int id;
  late int noOfPlants;
  late List<int> plantAssoc;
}

@RealmModel()
class _PlantInformer {
  @PrimaryKey()
  @MapTo('_idP')
  late int id;
  late String name;
  late String shortDesc;
  late String longDesc;
  late int timeToGrow;
  late int attensionTime;
  late List<String> promptHist;
}

// Getters and Setters
class HardwareUpdate {
  late int id;
  late String name;
  late String ip;
  late String ssid;
  late String passwd;
  late RealmList<int> gardenAssoc;

  HardwareUpdate(
      this.id, this.name, this.ip, this.ssid, this.passwd, this.gardenAssoc);
  Future<void> updateData() async {
    final realm = await Realm.open(Configuration.local(([Hardware.schema])));
    var hardwareInfo = Hardware(id, name, ip, ssid, passwd);
    realm.write(() {
      realm.add(hardwareInfo);
    });
  }
}

Future<Widget> uiUpdateHardware(isOffline) async {
  final realm = await Realm.open(Configuration.local(([Hardware.schema])));
  final tasksListenable = realm.all<Hardware>().changes;
  return StreamBuilder<RealmResultsChanges<Hardware>>(
    stream: tasksListenable,
    builder: (context, espDevices) {
      if (espDevices.hasData || espDevices == null) {
        return Center(
            child: ListView(
          children: [
            const SizedBox(
              height: 40,
            ),
            Lottie.asset("assets/animation/empty.json"),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'No devices found',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ));
      }
      return GridView.builder(
        itemCount: espDevices.data?.results.length ?? 0,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final device = espDevices.data?.results[index];
          return GestureDetector(
            onTap: () {
              //TODO
            },
            child: Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.purple.shade50,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(2, 2),
                    blurRadius: 5,
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5),
                    offset: const Offset(-2, -2),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          'assets/images/devices.png',
                          fit: BoxFit.contain,
                          height: 70,
                          width: 70,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // TODO
                          // toggleOnOFF(device);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            isOffline
                                ? 'assets/images/off.png'
                                : 'assets/images/on.png',
                            fit: BoxFit.contain,
                            height: 35,
                            width: 35,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    child: Text(
                      isOffline ? 'OFFLINE' : "ONLINE",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        color: isOffline ? Colors.red : Colors.green,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    device!.name,
                    style: const TextStyle(
                      color: Color(0xff0f52ba),
                      fontSize: 20,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
