import 'package:flutter/material.dart';
import 'package:myapp/core/utils/constants/colors.dart';
import 'package:myapp/core/utils/themes/customthemes/texttheme.dart';

class TElevatedButtonTheme{
  TElevatedButtonTheme._();

  static final lightTheme= ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: TColors.primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      textStyle: TTexttheme.lightTheme.bodyLarge,
      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
    )
  );
  static final darkTheme= ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: TColors.primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      textStyle: TTexttheme.darkTheme.bodyLarge,
      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
    )
  );
}