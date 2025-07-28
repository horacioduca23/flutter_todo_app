import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../core/platform/platform_utils.dart';

class AdaptiveOutlinedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Widget? icon;
  final Color? foregroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;

  const AdaptiveOutlinedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.icon,
    this.foregroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.padding,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    if (isIOS) {
      return _buildCupertinoButton(context);
    }
    return _buildMaterialButton(context);
  }

  Widget _buildCupertinoButton(BuildContext context) {
    final bool isEnabled = onPressed != null;
    final Color effectiveForegroundColor = foregroundColor ?? Colors.purple;
    final Color effectiveBorderColor = borderColor ?? effectiveForegroundColor;
    final double effectiveBorderWidth = borderWidth ?? 1.0;
    final BorderRadius effectiveBorderRadius =
        borderRadius ?? BorderRadius.circular(12);
    final double effectiveHeight = height ?? 48.0;
    final double effectiveWidth = width ?? double.infinity;

    return SizedBox(
      width: effectiveWidth,
      height: effectiveHeight,
      child: CupertinoButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        child: Container(
          width: effectiveWidth,
          height: effectiveHeight,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: effectiveBorderRadius,
            border: Border.all(
              color: isEnabled ? effectiveBorderColor : AppColors.grey400,
              width: effectiveBorderWidth,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                IconTheme(
                  data: IconThemeData(
                    color: isEnabled
                        ? effectiveForegroundColor
                        : AppColors.grey400,
                    size: 20,
                  ),
                  child: icon!,
                ),
                const SizedBox(width: 8),
              ],
              DefaultTextStyle(
                style: TextStyle(
                  color: isEnabled
                      ? effectiveForegroundColor
                      : AppColors.grey400,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMaterialButton(BuildContext context) {
    final effectiveHeight = height ?? 48.0;
    final effectiveWidth = width ?? double.infinity;

    return SizedBox(
      width: effectiveWidth,
      height: effectiveHeight,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: icon ?? const SizedBox.shrink(),
        label: child,
        style: OutlinedButton.styleFrom(
          foregroundColor: foregroundColor,
          side: BorderSide(
            color: borderColor ?? (foregroundColor ?? Colors.purple),
            width: borderWidth ?? 1.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
          ),
          padding: padding,
        ),
      ),
    );
  }
}
