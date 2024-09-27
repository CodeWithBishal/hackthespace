import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

Future<String> fetchGardenImage() async {
  final String url =
      'https://api.iconfinder.com/v4/icons/search?query=trees&count=10';
  final Map<String, String> headers = {
    'accept': 'application/json',
    'Authorization':
        'Bearer YsBEu5FVRWg80oiUdqBsSkAZbm0O6Acw5Ww5pUhPprb5UjAZAGl7WFZszLCDP7Wi',
  };

  // Perform the GET request
  final response = await http.get(Uri.parse(url), headers: headers);
  Random random = Random();
  int randomIndex = random.nextInt(9);

  late String jsonResponse = "";
  if (response.statusCode == 200) {
    jsonResponse = json.decode(response.body)["icons"][randomIndex]
        ["raster_sizes"][7]["formats"][0]["preview_url"];
  }
  return jsonResponse;
}
