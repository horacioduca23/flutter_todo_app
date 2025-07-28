import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../core/platform/platform_utils.dart';

class AdaptiveButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final bool isFilled;

  const AdaptiveButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.color,
    this.padding,
    this.borderRadius,
    this.isFilled = true,
  });

  @override
  Widget build(BuildContext context) {
    if (isIOS) {
      return CupertinoButton(
        onPressed: onPressed,
        color: isFilled ? color ?? AppColors.blackCupertino : null,
        padding: padding,
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        child: child,
      );
    }
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
      ),
      child: child,
    );
  }
}
