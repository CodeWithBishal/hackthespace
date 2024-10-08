import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:innovatika/database/informer_plant.dart';
import 'package:innovatika/widget/appbar.dart';
import 'package:innovatika/widget/garden_api.dart';
import 'package:innovatika/widget/garden_widget.dart';
import 'package:innovatika/widget/gemini.dart';
import 'package:innovatika/widget/plant_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:toastification/toastification.dart';

class PlantDetails extends StatefulWidget {
  final Plant plant;
  final String location;
  const PlantDetails({
    super.key,
    required this.plant,
    required this.location,
  });

  @override
  State<PlantDetails> createState() => _PlantDetailsState();
}

class _PlantDetailsState extends State<PlantDetails> {
  Uint8List? imageMem;
  // late PlantDesc plantDesc = PlantDesc(
  //   description: "",
  //   technique: "",
  // );

  final TextEditingController gardenNameC = TextEditingController();

  late bool isShowpage = false;
  Future fetchDescription() async {
    final stringJsonData = await GeminiClient(model: "gemini-1.5-flash-latest")
        .generateContentFromText(
      prompt:
          'Hi, I am trying to plant ${widget.plant.name} in my location ${widget.location}, first give me a brief description of the plant, some growing techniques and suggest me some caring techniques, give me the output strictly in json format and no other text, remove any kind of formatting and remove all newline characters. remember output strictly in json format and no other text. here is the format(key value): {"description": "All description goes here", "techniques":"All techniques goes here", "timeToGrow":"actual growing time in 10 letters"} in minimum 200 words,techniques must only contain the growing techniques and description should only contain a description, description and techniques should be strictly unique. both description and techniques keys should be present and strictly only json',
    );

    final Map<String, dynamic> jsonData = jsonDecode(stringJsonData);

    setState(() {
      widget.plant.longDesc = jsonData["description"] ?? "";
      widget.plant.shortDesc = jsonData["techniques"] ?? "";
      widget.plant.timeToGrow = jsonData["timeToGrow"] ?? "";
    });

    if (widget.plant.longDesc.isEmpty || widget.plant.shortDesc.isEmpty) {
      if (!mounted) return;
      fetchDescription();
    } else {
      setState(() {
        isShowpage = true;
      });
    }
  }

  void addGardenFn(
    BuildContext context,
    int gardenID,
  ) async {
    final url = await fetchGardenImage();
    GardenManager().addGarden(gardenID, url);
    var plantList = await PlantManager().listPlant();
    int plantLastID = 0;
    if (plantList.isNotEmpty) {
      plantLastID = plantList.last?.id + 1 ?? 0;
    }
    PlantManager().addPlant(widget.plant, plantLastID);
    GardenManager().addAssociates(
      gardenID,
      plantLastID,
    );
    if (!context.mounted) return;
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      alignment: Alignment.bottomCenter,
      autoCloseDuration: const Duration(seconds: 5),
      title: Text(
        "Garden Added Successfully",
        textAlign: TextAlign.center,
      ),
    );
    Navigator.of(context).pop();
  }

  void addPlant(int gardenID) async {
    var plantList = await PlantManager().listPlant();
    int plantLastID = 0;
    if (plantList.isNotEmpty) {
      plantLastID = plantList.last?.id + 1 ?? 0;
    }
    PlantManager().addPlant(widget.plant, plantLastID);
    GardenManager().addAssociates(
      gardenID,
      plantLastID,
    );
    if (!mounted) return;
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      alignment: Alignment.bottomCenter,
      autoCloseDuration: const Duration(seconds: 5),
      title: Text(
        "Plant Added Successfully",
        textAlign: TextAlign.center,
      ),
    );
    Navigator.of(context).pop();
  }

  Future loadNetworkImg() async {
    http.Response response = await http.get(
      Uri.parse(
        widget.plant.image,
      ),
    );
    // final Uint8List img = await removeBG(response.bodyBytes);
    setState(() {
      imageMem = response.bodyBytes;
    });
    return imageMem;
  }

  @override
  void initState() {
    loadNetworkImg().then((onValue) {
      fetchDescription();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    ///

    void listGardens(BuildContext context, List<dynamic> garden, int gardenID) {
      // late bool isLoading = false;
      // final width = MediaQuery.of(context).size.width;
      // final height = MediaQuery.of(context).size.height;
      showModalBottomSheet(
        backgroundColor: Color.fromARGB(255, 237, 228, 251),
        context: context,
        isScrollControlled: false,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: garden.length,
                    itemBuilder: (context, index) {
                      var garData = garden[index];
                      return GestureDetector(
                        onTap: () {
                          addPlant(garData.id);
                        },
                        child: ListTile(
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
                      );
                    },
                  ),
                ),
                Divider(),
                TextButton.icon(
                  onPressed: () {
                    addGardenFn(context, gardenID + 1);
                  },
                  icon: Icon(Iconsax.add),
                  label: Text("Add Garden"),
                )
              ],
            );
          });
        },
      );
    }

    ////
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonApp(
        context: context,
        title: widget.plant.name,
      ),
      body: isShowpage
          ? ListView(
              children: [
                Container(
                  // width: width / 20,
                  height: height / 2.5,
                  color: Colors.white,
                  child: SizedBox(
                    // color: Colors.amber,
                    height: height / 2.5,
                    width: width,
                    child: Image.memory(
                      imageMem!,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(2),
                  padding: const EdgeInsets.all(20),
                  width: width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.plant.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          fontFamily: "Ubuntu",
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              widget.plant.timeToGrow,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                fontFamily: "Ubuntu",
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton.icon(
                              onPressed: () async {
                                final garden =
                                    await GardenManager().listGarden();

                                if (!context.mounted) return;
                                if (garden.isEmpty) {
                                  addGardenFn(context, 0);
                                } else {
                                  var gardenList =
                                      await GardenManager().listGarden();
                                  int gardenID = gardenList.last?.id ?? 0;
                                  if (!context.mounted) return;
                                  listGardens(context, garden, gardenID);
                                }
                                //                       PlantManager().addPlant(widget.plant);
                                //                       toastification.show(
                                //   context: context,
                                //   type: ToastificationType.success,
                                //   style: ToastificationStyle.flat,
                                //   alignment: Alignment.bottomCenter,
                                //   autoCloseDuration: const Duration(seconds: 5),
                                //   title: Text(
                                //     "Plan",
                                //     textAlign: TextAlign.center,
                                //   ),
                                // );
                              },
                              style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  Color(
                                    0xffffe6e6,
                                  ),
                                ),
                              ),
                              label: const Text(
                                "Save",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 146, 146),
                                ),
                              ),
                              icon: const Icon(
                                Icons.favorite,
                                color: Color.fromARGB(
                                  255,
                                  255,
                                  146,
                                  146,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        "Description",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black54,
                          fontFamily: "Montserrat",
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        widget.plant.longDesc,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: "Ubuntu",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Growing Techniques",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black54,
                          fontFamily: "Montserrat",
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        widget.plant.shortDesc,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: "Ubuntu",
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          : animatedLoader(),
    );
  }

  Widget animatedLoader() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Lottie.asset("assets/animation/wait.json"),
          const SizedBox(
            height: 50,
          ),
          const Text(
            "Communing with the Plant Spirits...",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "Connecting with plant spirits to weave tales inspired by your location, creating a truly immersive experience.",
            style: TextStyle(
              color: Colors.black38,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
