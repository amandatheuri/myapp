import 'package:flutter/material.dart';
import 'package:myapp/core/utils/constants/colors.dart';
import 'package:myapp/core/utils/themes/customthemes/texttheme.dart';

class TTextField{
  TTextField._();
  static InputDecorationTheme allThemes = InputDecorationTheme(
    border: OutlineInputBorder().copyWith( borderSide: BorderSide(color: TColors.primaryColor),
      borderRadius: BorderRadius.circular(20)),
      focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[700] ?? Colors.grey),
      borderRadius: BorderRadius.circular(20)),
      enabledBorder: OutlineInputBorder().copyWith(
      borderSide: BorderSide(color: TColors.primaryColor),
      borderRadius: BorderRadius.circular(20),
    ),
    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: TColors.errorColor), borderRadius: BorderRadius.circular(20)),
    focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: TColors.errorColor), borderRadius: BorderRadius.circular(20)),
    floatingLabelAlignment: FloatingLabelAlignment.start,
    labelStyle: TTexttheme.lightTheme.bodySmall?.copyWith(color: Colors.grey[700]),
    hintStyle: TTexttheme.lightTheme.bodySmall?.copyWith(color: Colors.grey[700]),
    prefixIconColor: Colors.grey[700],
    suffixIconColor: Colors.grey[700],
    errorMaxLines: 3,
    errorStyle: TTexttheme.lightTheme.bodySmall?.copyWith(color: Colors.red),
    contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0)
  );
}