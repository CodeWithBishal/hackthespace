import 'dart:convert';

import 'package:innovatika/database/informer_plant.dart';
import 'package:innovatika/widget/gemini.dart';

List<Plant> handleFruitMapping(geminiData) {
  late List<Plant> fruit;
  late List<dynamic> fruitJsonData;
  if (geminiData.toString().contains("json")) {
    final data =
        GeminiClient(model: "gemini-1.5-flash-latest").extractCodeBlock(
      geminiData,
    );
    fruitJsonData = json.decode(data);
    // fruit = Plant(id: 1, name: fruitJsonData[""], image: image, shortDesc: shortDesc, longDesc: longDesc, timeToGrow: timeToGrow, attensionTime: attensionTime);
    fruit = fruitJsonData.map<Plant>((json) => Plant.fromJson(json)).toList();
  } else {
    fruitJsonData = json.decode(geminiData);

    fruit = fruitJsonData.map<Plant>((json) => Plant.fromJson(json)).toList();
  }
  return fruit;
}

List<Plant> handleVeggiesMapping(geminiData) {
  late List<dynamic> veggiesJsonData;
  late List<Plant> veggies;
  if (geminiData.toString().contains("json")) {
    final data = GeminiClient(model: "gemini-1.5-flash-latest")
        .extractCodeBlock(geminiData);
    veggiesJsonData = json.decode(data);

    veggies =
        veggiesJsonData.map<Plant>((json) => Plant.fromJson(json)).toList();
  } else {
    veggiesJsonData = json.decode(geminiData);

    veggies =
        veggiesJsonData.map<Plant>((json) => Plant.fromJson(json)).toList();
  }
  return veggies;
}

List<Plant> handleFlowerMapping(geminiData) {
  late List<dynamic> flowersJsonData;
  late List<Plant> flower;
  if (geminiData.toString().contains("json")) {
    final data = GeminiClient(model: "gemini-1.5-flash-latest")
        .extractCodeBlock(geminiData);
    flowersJsonData = json.decode(data);
    flower =
        flowersJsonData.map<Plant>((json) => Plant.fromJson(json)).toList();
  } else {
    flowersJsonData = json.decode(geminiData);

    flower =
        flowersJsonData.map<Plant>((json) => Plant.fromJson(json)).toList();
  }
  return flower;
}

List<Plant> handleHerbsMapping(geminiData) {
  late List<Plant> herbs;
  late List<dynamic> herbsJsonData;
  if (geminiData.toString().contains("json")) {
    final data = GeminiClient(model: "gemini-1.5-flash-latest")
        .extractCodeBlock(geminiData);
    herbsJsonData = json.decode(data);

    herbs = herbsJsonData.map<Plant>((json) => Plant.fromJson(json)).toList();
  } else {
    herbsJsonData = json.decode(geminiData);

    herbs = herbsJsonData.map<Plant>((json) => Plant.fromJson(json)).toList();
  }
  return herbs;
}

List<Plant> handleShrubsMapping(geminiData) {
  late List<Plant> shrubs;
  late List<dynamic> shrubsJsonData;
  if (geminiData.toString().contains("json")) {
    final data = GeminiClient(model: "gemini-1.5-flash-latest")
        .extractCodeBlock(geminiData);
    shrubsJsonData = json.decode(data);

    shrubs = shrubsJsonData.map<Plant>((json) => Plant.fromJson(json)).toList();
  } else {
    shrubsJsonData = json.decode(geminiData);
    shrubs = shrubsJsonData.map<Plant>((json) => Plant.fromJson(json)).toList();
  }
  return shrubs;
}
