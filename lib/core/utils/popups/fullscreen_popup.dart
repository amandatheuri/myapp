import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/widgets/animationloader/animationloader.dart';
class TFullscreenLoader{
  
  static void openLoadingDialog (String text, String animation){
    showDialog(context: Get.overlayContext!,barrierDismissible: false, builder: (_)=>PopScope(
      canPop: false,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child:Column(children: [
          const SizedBox(height: 250),
          TAnimatedLoader(animation: animation, text: text)
        ],)
      ) 
      ));
  }

static stopLoading(){
  Navigator.of(Get.overlayContext!).pop();
}
}