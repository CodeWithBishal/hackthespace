import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:unsplash_client/unsplash_client.dart';

Future fetchImgUnsplash(String query, bool isList) async {
  await dotenv.load(fileName: 'assets/env/unsplash.env');
  final accessKey = dotenv.env['accessKey'];
  final secretKey = dotenv.env['secretKey'];
  final client = UnsplashClient(
    settings: ClientSettings(
      credentials: AppCredentials(
        accessKey: accessKey ?? "",
        secretKey: secretKey ?? "",
      ),
    ),
  );
  final photos = await client.photos.random(query: query).goAndGet();
  if (isList) {
    return photos;
  } else {
    return photos.first.urls.thumb;
  }
}
