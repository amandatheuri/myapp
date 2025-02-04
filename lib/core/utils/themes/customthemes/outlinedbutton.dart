import 'package:flutter/material.dart';
import 'package:myapp/core/utils/constants/colors.dart';
import 'package:myapp/core/utils/themes/customthemes/texttheme.dart';

class TOutlinedButton {
  TOutlinedButton._();

  static final lightTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      textStyle: TTexttheme.lightTheme.bodyLarge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      side: BorderSide(color: TColors.primaryColor),
    )
  );
  static final darkTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      textStyle: TTexttheme.darkTheme.bodyLarge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      side: BorderSide(color: TColors.primaryColor),
    )
  );
}