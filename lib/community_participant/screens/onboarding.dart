import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/community_participant/controllers/onboardingcontroller.dart';
import 'package:myapp/core/utils/constants/imagestrings.dart';
import 'package:myapp/core/utils/constants/textstrings.dart';
import 'package:myapp/community_participant/widgets/onboardingwidgets/onboardingpages.dart';
import 'package:myapp/community_participant/widgets/onboardingwidgets/pageindicator.dart';
import 'package:myapp/community_participant/widgets/onboardingwidgets/skipbutton.dart';
import '../widgets/onboardingwidgets/circularbutton.dart';

class OnboardingScreen extends StatelessWidget {
  // Initialize GetX Controller
  final OnboardingController controller = Get.put(OnboardingController());

  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            /// Onboarding Pages
            PageView(
              controller: controller.pageController,
              onPageChanged: (index) {
                controller.updateCurrentPage(index); // Ensure this updates state correctly
              },
              children: [
                OnboardingPages(
                  image: TImageStrings.onboarding1,
                  title: TTextstrings.onboarding1Title,
                  subtitle: TTextstrings.onboarding1Subtitle,
                ),
                OnboardingPages(
                  image: TImageStrings.onboarding2,
                  title: TTextstrings.onboarding2Title,
                  subtitle: TTextstrings.onboarding2Subtitle,
                ),
                OnboardingPages(
                  image: TImageStrings.onboarding3,
                  title: TTextstrings.onboarding3Title,
                  subtitle: TTextstrings.onboarding3Subtitle,
                ),
              ],
            ),
            const SkipButton(),
            const PageIndicator(),
            CircularButton(),
          ],
        ),
      
    );
  }
}
