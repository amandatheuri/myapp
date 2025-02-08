import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:myapp/core/utils/constants/colors.dart';
import 'package:myapp/core/utils/device/deviceutility.dart';
import 'package:myapp/screens/wallet.dart';
import 'package:myapp/widgets/menulist/menulist.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});
  @override
  Widget build(BuildContext context) {
    final bool isDark = TDevice.isDarkMode(context);
    double avatarSize = TDevice.getScreenWidth(context) * 0.1;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Profile',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Column( 
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children:[ Expanded(
                  child: SizedBox(
                    height: avatarSize * 2.3, 
                    child: Stack(
                      children: [
                          CircleAvatar(
                            radius: avatarSize,
                            backgroundColor: Colors.grey[700],
                            child: const Icon(Iconsax.camera, color: Colors.white, size: 25),
                          ),
                        Positioned(
                          bottom: 0, 
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            height: 30, width: 30,
                            decoration: BoxDecoration(
                              color: TColors.primaryColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: TColors.primaryColor.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: const Icon(Icons.edit, color: Colors.white, size: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
              
                 const Spacer(), 
                Expanded(
                  flex:2,
                  child: Column(
                  children:[Text(
                      "Jane Doe",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold
                        ),
                    ),
                               
                  const SizedBox(height: 2.5),
                  Text(
                    "janedoe@gmail.com",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold
                      ),
                  ),
                                 const SizedBox(height: 15),
                                 Center(
                                 child: SizedBox(
                                 width: 135,  
                                 height: 40,  
                                 child: OutlinedButton(
                                 onPressed: () {}, 
                                 child: Text(
                                 'Edit Profile', 
                                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                 fontSize: 16, 
                                 fontWeight: FontWeight.bold,
                                 ),),),
                                 ),
                                ),
                                ],
                                ),
                ),
              ]
              ),
              const SizedBox(height: 15),
              const Divider(color: Colors.grey),
              const SizedBox(height: 5),
              MenuList(title: 'Settings', icon: Icons.settings_outlined, onPress:(){}, textColor: Colors.grey[700],),
              MenuList(title: 'Token Wallet', icon: Iconsax.coin, onPress:(){Get.to(()=>WalletScreen());}, textColor: Colors.grey[700],),
              MenuList(title: 'Notifications', icon: Iconsax.notification, onPress:(){}, textColor: Colors.grey[700]),
              MenuList(title: 'Analytics', icon: Iconsax.chart_1, onPress:(){}, textColor: Colors.grey[700]),
              MenuList(title: 'Referal code', icon: Icons.share_rounded, onPress:(){}, textColor: Colors.grey[700]),
              const SizedBox(height: 10),
              const Divider(color: Colors.grey),
              MenuList(title: 'FAQs', icon: Iconsax.document, onPress:(){}, textColor: Colors.grey[700]),
              MenuList(title: 'Help', icon: Iconsax.message_question, onPress:(){}, textColor: Colors.grey[700]),
              Center(child: MenuList(title: 'Logout', icon: Iconsax.logout, onPress:(){}, textColor: isDark? Colors.white:Colors.red, endIcon: false)),
              
            ],
        ),
      ),
      )
    );
  }
}

