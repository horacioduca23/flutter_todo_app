import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../core/platform/platform_utils.dart';

class FieldSectionTitle extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry? margin;

  const FieldSectionTitle({super.key, required this.title, this.margin});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      alignment: Alignment.centerLeft,
      margin: margin ?? const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: isIOS ? 17 : 16,
          color: isIOS ? AppColors.grey600 : Colors.black87,
          letterSpacing: 0.1,
        ),
      ),
    );
  }
}
