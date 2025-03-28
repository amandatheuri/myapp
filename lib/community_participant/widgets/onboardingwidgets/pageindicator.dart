import 'package:flutter/material.dart';
import 'package:myapp/community_participant/controllers/onboardingcontroller.dart';
import 'package:myapp/core/utils/constants/colors.dart';
import 'package:myapp/core/utils/device/deviceutility.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;
    return Positioned(
      bottom: TDevice.getbottomappbarheight()+15,
      left: 24,
      child: SmoothPageIndicator
      (
        controller: controller.pageController, onDotClicked: controller.updateCurrentPage,
        count: 3,
        effect: ExpandingDotsEffect(activeDotColor: TColors.primaryColor, dotHeight: 5, dotWidth: 10, radius: 25, spacing: 5,),
      )
      );
  }
}




