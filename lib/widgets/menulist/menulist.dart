import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:myapp/core/utils/constants/colors.dart';

class MenuList extends StatelessWidget {
  const MenuList(
     {
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon= true,
    this.textColor
  });
final String title;
final IconData icon;
final VoidCallback onPress;
final bool endIcon;
final  Color? textColor;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        height: 35,
        width: 35,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: TColors.primaryColor.withOpacity(0.2),
        ),
        child: Icon(icon, color: TColors.primaryColor, size: 17.5),
      ),
      title: Text(
      title, 
      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: textColor)),
      trailing: endIcon? Container(
        height: 30,
        width: 30,
        padding: EdgeInsets.all(8.0),
        child: Icon(Iconsax.arrow_right_3, 
        color: Colors.grey[700], 
        size: 18
        ),
      ):null,
    );
  }
}
