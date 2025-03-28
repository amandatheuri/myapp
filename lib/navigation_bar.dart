import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:myapp/community_participant/controllers/navcontroller.dart';
import 'package:myapp/core/utils/constants/colors.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
            height: 70,
            elevation: 3,
            selectedIndex: controller.selectedIndex.value,
            indicatorColor: TColors.primaryColor,
            backgroundColor: Colors.transparent,
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
            destinations: [
              NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
              NavigationDestination(icon: Icon(Iconsax.shop), label: 'Rewards'),
              NavigationDestination(
                  icon: Icon(Iconsax.trash), label: 'Dispose'),
              NavigationDestination(
                  icon: Icon(Iconsax.shield), label: 'Challenges'),
            ]),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}
