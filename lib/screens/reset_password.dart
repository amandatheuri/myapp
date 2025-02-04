import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:myapp/core/utils/constants/colors.dart';
import 'package:myapp/core/utils/constants/imagestrings.dart';
import 'package:myapp/core/utils/constants/textstrings.dart';
import 'package:myapp/core/utils/device/deviceutility.dart';
import 'package:myapp/navigation_bar.dart';
import 'package:myapp/screens/forgot_password.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = TDevice.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
         padding: EdgeInsets.only(
            top: 150,
            left: 18.0,
            right: 18.0,
            bottom: 24.0
         ),
           child: Column(
            children: [
              Align(
                alignment: Alignment.center,
              ),
                 Image(
                  image: AssetImage(
                    TImageStrings.emailsent,
                  ),
                  width: TDevice.getScreenWidth(context) * 0.6,
                
              ),
              const SizedBox(height: 40),
              Text(
                TTextstrings.emailSent,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
               Text(
                TTextstrings.emailSentMessage,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: (){
                   Get.to(()=> NavBar());
                  },
                  child: Text(
                    TTextstrings.next,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: TColors.primaryColor,
                          ),
                        ),
                  onPressed: (){
                   Get.to(()=>ForgotPassword());
                  },
                  child: Text(
                    TTextstrings.resend,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark? Colors.white : Colors.black
                    ),
                  ),
                )
              )
            ],
        )
      )
      )
      
    );
  }
}