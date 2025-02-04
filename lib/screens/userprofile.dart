import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:myapp/core/utils/device/deviceutility.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),),
      ),
      body: Stack(
        children:[ Container(
          height: TDevice.getScreenHeight(context)*0.3,
          color: Colors.transparent,
          child: Center(child: Icon(Iconsax.user, size: 100, color: Colors.grey,)),
        ),
        ]
      ),
    );
  }
}