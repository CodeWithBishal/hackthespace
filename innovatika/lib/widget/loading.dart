import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingDeviceAnimation extends StatelessWidget {
  const LoadingDeviceAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LottieBuilder.asset(
        "assets/animation/camera_loading.json",
      ),
    );
  }
}

Widget videoLoadingAnimation() {
  return Center(
    child: LottieBuilder.asset(
      "assets/animation/video_loading.json",
    ),
  );
}

Widget emptyLoading() {
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
