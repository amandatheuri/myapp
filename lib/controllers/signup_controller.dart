import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/core/utils/constants/imagestrings.dart';
import 'package:myapp/core/utils/helpers/network_manager.dart';
import 'package:myapp/core/utils/loaders/TLoaders.dart';
import 'package:myapp/core/utils/popups/fullscreen_popup.dart';
import 'package:myapp/models/usermodel.dart';
import 'package:myapp/repository/auth_repo.dart';
import 'package:myapp/screens/success.dart';
import 'package:myapp/repository/user_repo.dart';


class SignupController extends GetxController{
  static SignupController instance = Get.find();
  //variables
  final hidePassword = true.obs;
  final checkBox = true.obs;
  final userFirstName = TextEditingController();
  final userLastName = TextEditingController();
  final userName = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
 GlobalKey<FormState> formKey = GlobalKey<FormState>();

 void signupUser() async {
  try{
    //start loading
   //TFullscreenLoader.openLoadingDialog('Processing your information', TImageStrings.onboarding1);
   //network connection
   final isConnected = await NetworkManager.instance.isConnected();
   if(!isConnected){
        TFullscreenLoader.stopLoading();
    return;
   }
   //form validation
   if(!formKey.currentState!.validate()){
       TFullscreenLoader.stopLoading();
    return;}
   //register and store user in firebase
   final userCredential = await AuthRepo.instance.signUpWithEmailAndPassword(email.text.trim(), password.text.trim());
   //store user in firestore
   final newUser = UserModel(
  uid: userCredential?.user?.uid ?? '', // Get UID from Firebase Auth
  firstName: userFirstName.text.trim(),
  lastName: userLastName.text.trim(),
  userName: userName.text.trim(),
  email: email.text.trim(),
  phoneNumber: phoneNumber.text.trim(),
  token: 0, 
  wasteCollected: 0.0, 
  profileSticker: null,
);
final userRepo = Get.put(UserRepo());
await userRepo.saveUserCredentials(newUser);
    TFullscreenLoader.stopLoading();

TLoaders.successSnackBar(title: 'Congratulations', message: 'Your account has been created!');
Get.to(()=>const Success());
  } catch(e){
      TFullscreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
  }
 }
}