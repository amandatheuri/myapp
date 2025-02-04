import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:myapp/core/utils/constants/textstrings.dart';
import 'package:myapp/screens/reset_password.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: Padding(padding: EdgeInsets.only(
          left: 24.0,
          right: 24.0,
          top: 20,
          bottom: 24.0,
         ),
         child: Column(
          
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
        Align(
          alignment: Alignment.center,
          child: Text("FORGOT PASSWORD",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 35),
         Text('Enter email',
         style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
         ),
         SizedBox(height: 10),
         Text('Enter the email address associated with your account',
         style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Colors.grey
         ),
         ),
         SizedBox(height: 20),
         TextFormField(
           decoration: InputDecoration(
            labelText: TTextstrings.email,
            labelStyle: TextStyle(
            color: Colors.grey),
            prefixIcon: const Icon(Iconsax.direct_right),
           )
         ),
         const SizedBox(height: 20),
         SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: (){
              Get.to(() => ResetPassword());
            },
            child: Text('Reset Password',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold
            ),
            )
            )
            )
          ]
         )
       )
    );
  }
  

}