import 'package:flutter/material.dart';
import 'package:myapp/core/utils/constants/colors.dart';

class TBottomsheet{
  TBottomsheet._();

  static BottomSheetThemeData lightTheme = BottomSheetThemeData(
    backgroundColor: Colors.white,
    modalBackgroundColor: Colors.white,
    showDragHandle: true,
    elevation: 2,
    shadowColor: TColors.primaryColor,
    constraints: BoxConstraints(maxWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
  );

  static BottomSheetThemeData darkTheme = BottomSheetThemeData(
    backgroundColor: Colors.black,
    modalBackgroundColor: Colors.black,
    showDragHandle: true,
    elevation: 2,
    shadowColor: TColors.primaryColor,
    constraints: BoxConstraints(maxWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
  );
}