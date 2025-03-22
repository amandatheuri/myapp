import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TAnimatedLoader extends StatelessWidget {
  const TAnimatedLoader({
    super.key, 
    required this.animation, 
    required this.text, 
    this.showAction = false, 
    this.actionText,
    this.onActionPressed
    });
    final String text;
    final String animation;
    final bool showAction;
    final String? actionText;
    final VoidCallback? onActionPressed;

    @override
    Widget build(BuildContext context){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Lottie.asset(animation),
          const SizedBox(height:5),
          Text (text, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
          const SizedBox(height:5),
          showAction? SizedBox(
            width: 250,
            child: OutlinedButton(
              onPressed: onActionPressed,
              style: OutlinedButton.styleFrom(backgroundColor: Colors.transparent),
              child: Text(actionText!, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold))
            )
          ): const SizedBox()
        ]
      )
    );
    }
}