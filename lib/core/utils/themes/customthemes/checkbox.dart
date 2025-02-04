import 'package:flutter/material.dart';
import 'package:myapp/core/utils/constants/colors.dart';
 class TCheckBox {
  TCheckBox._();

  static CheckboxThemeData allThemes = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    checkColor: MaterialStateProperty.resolveWith((states){
      if (states.contains(MaterialState.selected)){
        return TColors.primaryColor;
      }else{
        return Colors.transparent;
      }
    }),
    fillColor: MaterialStateProperty.resolveWith((state){
      if(state.contains(MaterialState.selected)){
        return Colors.transparent;
      }else{
        return Colors.transparent;
      }
    }),
  );
  static CheckboxThemeData darkTheme = CheckboxThemeData();

 }