import 'package:flutter/material.dart';
import 'package:myapp/controllers/onboardingcontroller.dart';
import 'package:myapp/core/utils/device/deviceutility.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(top: TDevice.getappbarHeight(context), right: 24,
    child: TextButton( onPressed: () {OnboardingController.instance.skipPage();},
    child: Text('Skip', style:Theme.of(context).textTheme.bodySmall)));
  }
}