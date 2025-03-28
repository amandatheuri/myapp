import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/core/utils/device/deviceutility.dart';

class OnboardingPages extends StatelessWidget {
  const OnboardingPages({
    super.key,
    required this.image,
    required this.subtitle,
    required this.title,
  });

  final String title, image, subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centers content vertically
        crossAxisAlignment: CrossAxisAlignment.center, // Centers content horizontally
        children: [
          // Display Lottie animation
          Lottie.asset(
            image, // Path to Lottie animation
            width: TDevice.getScreenWidth(context) * 0.8,
            height: TDevice.getScreenHeight(context) * 0.5, // Adjust height as needed
            fit: BoxFit.contain, // Ensures proper scaling
          ),
          Text(
            title,
            textAlign: TextAlign.center, // Centers text
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            textAlign: TextAlign.center, // Centers subtitle
            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.normal, color: Colors.grey[700]),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
