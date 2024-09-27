import 'dart:convert';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:innovatika/database/informer_plant.dart';
import 'package:innovatika/pages/plant_details.dart';
import 'package:innovatika/widget/gemini.dart';
import 'package:innovatika/widget/mapping.dart';
import 'package:innovatika/widget/unsplash_api.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toastification/toastification.dart';

class PlantCategorization extends StatefulWidget {
  const PlantCategorization({
    super.key,
  });

  @override
  State<PlantCategorization> createState() => _PlantCategorizationState();
}

class _PlantCategorizationState extends State<PlantCategorization> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage('assets/img/flower.png'), context);
    precacheImage(const AssetImage('assets/img/fruit.png'), context);
    precacheImage(const AssetImage('assets/img/vegetables.png'), context);
    precacheImage(const AssetImage('assets/img/herbs.png'), context);
    precacheImage(const AssetImage('assets/img/shrubs.png'), context);
    _preloadAnimation();
  }

  Future<void> _preloadAnimation() async {
    final animation1 = AssetLottie('assets/animatedImg/wait.json');
    await animation1.load();
    // setState(() {
    //   oldComposition = composition;
    // });
  }

  //
  //
  //
  late bool displayLocationPermission = true;
  late bool isGeminiRequestInProgress = true;
  late String locationCity;

  late List<Plant> fruit;
  late List<Plant> veggies;
  late List<Plant> flower;
  late List<Plant> herbs;
  late List<Plant> shrubs;
  //
  //
  final futureGroup = FutureGroup();
  //
  // late List<dynamic> fruitJsonData;
  // late List<dynamic> veggiesJsonData;
  // late List<dynamic> flowersJsonData;
  // late List<dynamic> herbsJsonData;
  // late List<dynamic> shrubsJsonData;
  //

  //
  void locationError(BuildContext context, String description) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.flat,
      alignment: Alignment.bottomCenter,
      autoCloseDuration: const Duration(seconds: 5),
      title: const Text('Location Permission Denied!'),
      description: Text(description),
      // description: const Text(
      //   "Location Permission is Denied, kindly turn it on from the settings",
      // ),
    );
  }

  void locationSuccess(BuildContext context) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      alignment: Alignment.bottomCenter,
      autoCloseDuration: const Duration(seconds: 5),
      title: const Text(
        'Location Permission Granted!',
        textAlign: TextAlign.center,
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (!mounted) return Future.error("buildcontext error");
      locationError(
        context,
        "Location services are disabled, Please turn it on from the device settings",
      );
      setState(() {
        displayLocationPermission = true;
      });
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (!mounted) return Future.error("buildcontext error");
        locationError(
          context,
          "Location Permission is Denied, kindly turn it on from the settings",
        );
        setState(() {
          displayLocationPermission = true;
        });
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (!mounted) return Future.error("buildcontext error");
      locationError(context,
          "Location Permission is Denied, kindly turn it on from the settings");
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    if ((permission == LocationPermission.whileInUse ||
            permission == LocationPermission.always) &&
        serviceEnabled == true) {
      setState(() {
        displayLocationPermission = false;
      });
      if (!mounted) return Future.error("buildcontext error");
      locationSuccess(context);
    }

    return await Geolocator.getCurrentPosition();
  }

  Future processGemReq(String category, String locationCity) async {
    var geminiData = await GeminiClient(
      model: "gemini-1.5-flash-latest",
    ).generateContentFromText(
      prompt:
          'Hi, I am looking for some plants that can be planted in: $locationCity i want no other text just json only also i want it categories $category that for every plant it contains these keys [name, image, time_to_grow]. keep the value of image key to "default" Strictly only json and no text and image url should return status code 200, give a maximum of 5',
    );

    if (category == "fruit") {
      setState(() {
        fruit = handleFruitMapping(geminiData);
      });
      for (int i = 0; i < fruit.length; i++) {
        var img = await fetchImgUnsplash(fruit[i].name);
        setState(() {
          fruit[i].image = img.toString();
        });
      }
    }
    if (category == "veggies") {
      veggies = handleVeggiesMapping(geminiData);
      for (int i = 0; i < veggies.length; i++) {
        var img = await fetchImgUnsplash(veggies[i].name);
        setState(() {
          veggies[i].image = img.toString();
        });
      }
    }
    if (category == "Flowers") {
      flower = handleVeggiesMapping(geminiData);
      for (int i = 0; i < flower.length; i++) {
        var img = await fetchImgUnsplash(flower[i].name);
        setState(() {
          flower[i].image = img.toString();
        });
      }
    }
    if (category == "herbs") {
      herbs = handleVeggiesMapping(geminiData);
      for (int i = 0; i < herbs.length; i++) {
        var img = await fetchImgUnsplash(herbs[i].name);
        setState(() {
          herbs[i].image = img.toString();
        });
      }
    }
    if (category == "shrubs") {
      shrubs = handleVeggiesMapping(geminiData);
      for (int i = 0; i < shrubs.length; i++) {
        var img = await fetchImgUnsplash(shrubs[i].name);
        setState(() {
          shrubs[i].image = img.toString();
        });
      }
    }
  }

  void callAPI() {
    // parallel processing of API
    futureGroup.add(processGemReq("fruit", locationCity));
    futureGroup.add(processGemReq("veggies", locationCity));
    futureGroup.add(processGemReq("Flowers", locationCity));
    futureGroup.add(processGemReq("herbs", locationCity));
    futureGroup.add(processGemReq("shrubs", locationCity));
    futureGroup.close();
    futureGroup.future.then((onValue) {
      setState(() {
        isGeminiRequestInProgress = false;
      });
    });
  }

  Future geminiReq() async {
    final Position position = await _determinePosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    setState(() {
      locationCity = placemarks[0].locality ?? "India";
    });

    callAPI();

    //fruit catalogue
    // final fruitData = await processGemReq("fruit", locationCity);

    // //veggies catalogue
    // final veggiesData = await processGemReq("veggies", locationCity);

    // //Flowers catalogue
    // final flowersData = await processGemReq("Flowers", locationCity);

    // //Herbs catalogue
    // final herbsData = await processGemReq("herbs", locationCity);

    // //Shrubs catalogue
    // final shrubsData = await processGemReq("shrubs", locationCity);

    // setState(() {
    //   isGeminiRequestInProgress = false;
    // });
  }

  @override
  void initState() {
    geminiReq();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Parse the JSON data
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 255, 248),
      // appBar: AppBar(title: const Text('Plant Categorization')),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 242, 255, 248),
        automaticallyImplyLeading: false,
        actions: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_outlined,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
      body: displayLocationPermission
          ? locationAnimation()
          : isGeminiRequestInProgress
              ? geminiReqAnimation(width)
              : plantCatalogue(),
    );
  }

  Widget locationAnimation() => Center(
        child: ListView(
          children: [
            Lottie.asset("assets/animatedImg/location.json"),
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Allow Location Access",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "We need location permission to show personalised plant recommendation based on your location.",
              style: TextStyle(
                color: Colors.black38,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () async {
                await openAppSettings();
              },
              child: const Text(
                "Open Location Settings",
              ),
            )
          ],
        ),
      );
  Widget geminiReqAnimation(double width) {
    return ListView(
      children: [
        Lottie.asset("assets/animatedImg/geminiReqAnimation.json"),
        const SizedBox(
          height: 50,
        ),
        const Text(
          "Embrace Nature's Lore",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            color: Color(0xFF333333),
            fontWeight: FontWeight.bold,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(18.0),
          child: Text(
            "Tapping into nature's whispers to cultivate stories that bloom uniquely for you",
            style: TextStyle(
              color: Color.fromARGB(255, 50, 75, 60),
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget plantCatalogue() {
    return ListView(
      primary: true,
      children: [
        const SizedBox(
          height: 20,
        ),
        category1(flower),
        category2(fruit),
        category3(veggies),
        category4(herbs),
        category5(shrubs),
      ],
    );
  }

  Widget category1(List<Plant> plants) {
    return SizedBox(
      height: 200,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        primary: false,
        children: [
          Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                margin: const EdgeInsets.only(left: 20),
                child: ClipOval(
                  child: FractionallySizedBox(
                    widthFactor: 0.8, // 80% width of the parent container
                    heightFactor: 0.8, // 80% height of the parent container
                    child: Image.asset(
                      "assets/img/flower.png",
                      fit: BoxFit
                          .cover, // Cover the entire area of FractionallySizedBox
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              const Text(
                "Flowering Plants",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Ubuntu",
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.only(left: 30),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: plants.length,
              itemBuilder: (context, index) {
                Plant plant = plants[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlantDetails(
                          plant: plant,
                          location: locationCity,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.only(left: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        plant.image,
                        fit: BoxFit
                            .cover, // Cover the entire area of FractionallySizedBox
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget category2(List<Plant> plants) {
    return SizedBox(
      height: 200,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        primary: false,
        children: [
          Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                margin: const EdgeInsets.only(left: 20),
                child: ClipOval(
                  child: FractionallySizedBox(
                    widthFactor: 0.8, // 80% width of the parent container
                    heightFactor: 0.8, // 80% height of the parent container
                    child: Image.asset(
                      "assets/img/fruit.png",
                      fit: BoxFit
                          .cover, // Cover the entire area of FractionallySizedBox
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              const Text(
                "Fruit-Bearing Plants",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Ubuntu",
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.only(left: 30),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: plants.length,
              itemBuilder: (context, index) {
                Plant plant = plants[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlantDetails(
                          plant: plant,
                          location: locationCity,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.only(left: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        plant.image,
                        fit: BoxFit
                            .cover, // Cover the entire area of FractionallySizedBox
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget category3(List<Plant> plants) {
    return SizedBox(
      height: 200,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        primary: false,
        children: [
          Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                margin: const EdgeInsets.only(left: 20),
                child: ClipOval(
                  child: FractionallySizedBox(
                    widthFactor: 0.8, // 80% width of the parent container
                    heightFactor: 0.8, // 80% height of the parent container
                    child: Image.asset(
                      "assets/img/vegetables.png",
                      fit: BoxFit
                          .cover, // Cover the entire area of FractionallySizedBox
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              const Text(
                "Vegetables",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Ubuntu",
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.only(left: 30),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: plants.length,
              itemBuilder: (context, index) {
                Plant plant = plants[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlantDetails(
                          plant: plant,
                          location: locationCity,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.only(left: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        plant.image,
                        fit: BoxFit
                            .cover, // Cover the entire area of FractionallySizedBox
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget category4(List<Plant> plants) {
    return SizedBox(
      height: 200,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        primary: false,
        children: [
          Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                margin: const EdgeInsets.only(left: 20),
                child: ClipOval(
                  child: FractionallySizedBox(
                    widthFactor: 0.8, // 80% width of the parent container
                    heightFactor: 0.8, // 80% height of the parent container
                    child: Image.asset(
                      "assets/img/herbs.png",
                      fit: BoxFit
                          .cover, // Cover the entire area of FractionallySizedBox
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              const Text(
                "Herbs",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Ubuntu",
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.only(left: 30),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: plants.length,
              itemBuilder: (context, index) {
                Plant plant = plants[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlantDetails(
                          plant: plant,
                          location: locationCity,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.only(left: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        plant.image,
                        fit: BoxFit
                            .cover, // Cover the entire area of FractionallySizedBox
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget category5(List<Plant> plants) {
    return SizedBox(
      height: 200,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        primary: false,
        children: [
          Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                margin: const EdgeInsets.only(left: 20),
                child: ClipOval(
                  child: FractionallySizedBox(
                    widthFactor: 0.8, // 80% width of the parent container
                    heightFactor: 0.8, // 80% height of the parent container
                    child: Image.asset(
                      "assets/img/shrubs.png",
                      fit: BoxFit
                          .cover, // Cover the entire area of FractionallySizedBox
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              const Text(
                "Shrubs",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Ubuntu",
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.only(left: 30),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: plants.length,
              itemBuilder: (context, index) {
                Plant plant = plants[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlantDetails(
                          plant: plant,
                          location: locationCity,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.only(left: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        plant.image,
                        fit: BoxFit
                            .cover, // Cover the entire area of FractionallySizedBox
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
