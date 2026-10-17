import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128,
      height: 128,
      child: Center(child: Assets.images.fitflowLogo.svg()),
    );
  }
}
