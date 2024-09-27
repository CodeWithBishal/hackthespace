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
