// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:myapp/community_participant/controllers/onboardingcontroller.dart';
import 'package:myapp/core/utils/constants/colors.dart';
import 'package:myapp/core/utils/device/deviceutility.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = TDevice.isDarkMode(context);
    return Positioned( bottom: TDevice.getbottomappbarheight(), right: 24,
    child: 
    ElevatedButton(
      onPressed:(){OnboardingController.instance.nextPage();}, 
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(), 
        backgroundColor: TColors.primaryColor),
        child: Icon(Iconsax.arrow_right_3, color: isDark? Colors.white:Colors.black,)
    )
    );
  }
}
