import 'package:flutter/material.dart';
import 'package:innovatika/database/informer_hardware.dart';
import 'package:innovatika/widget/wifi.dart';
import 'package:lottie/lottie.dart';
import 'package:realm/realm.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late bool isOffline = true;
  Future<List<HardwareInformer>> fetchDevices() async {
    // Open a Realm instance
    var config =
        await Realm.open(Configuration.local(([HardwareInformer.schema])));

    // Fetch all users from MongoDB Realm
    var devices = config.all<HardwareInformer>().toList();
    return devices;
  }

  @override
  void initState() {
    // isPingSuccessful("192.168.4.1");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List<HardwareInformer>>(
        future: fetchDevices(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var devices = snapshot.data;
            return GridView.builder(
              itemCount: devices!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final device = devices[index];
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
                                'assets/images/device.jpg',
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
                          device.name,
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
          } else {
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
        },
      ),
    );
  }
}
