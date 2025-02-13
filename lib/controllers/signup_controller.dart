import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/core/utils/constants/imagestrings.dart';
import 'package:myapp/core/utils/loaders/TLoaders.dart';
import 'package:myapp/core/utils/popups/fullscreen_popup.dart';

class SignupController extends GetxController{
  static SignupController instance = Get.find();
  //variables
  final userFirstName = TextEditingController();
  final userName = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
 GlobalKey<FormState> formKey = GlobalKey<FormState>();

 Future<void> signupUser() async {
  try{
   TFullscreenLoader.openLoadingDialog('Processing your information', TImageStrings.onboarding1);
  }
  catch(e){
    TLoaders.errorSnackBar(title: 'Error', message: e.toString());
  }
 }
}