import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/core/utils/constants/imagestrings.dart';
import 'package:myapp/core/utils/constants/textstrings.dart';
import 'package:myapp/core/utils/device/deviceutility.dart';
import 'package:myapp/navigation_bar.dart';

class Success extends StatelessWidget {
  const Success({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
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
                 Image(
                  image: AssetImage(
                    isDark? TImageStrings.successDark : TImageStrings.success, 
                  ),
                  width: TDevice.getScreenWidth(context) * 0.6,
                
              ),
              const SizedBox(height: 20),
              Text(
                TTextstrings.success,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
               Text(
                TTextstrings.successMessage,
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
                    TTextstrings.getStarted, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
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