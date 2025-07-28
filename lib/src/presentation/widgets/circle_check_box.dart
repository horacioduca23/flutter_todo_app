import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../core/platform/platform_utils.dart';

class CircleCheckBox extends StatelessWidget {
  final bool value;
  final VoidCallback onTap;

  const CircleCheckBox({super.key, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: value ? AppColors.blue : Colors.transparent,
        border: Border.all(
          color: value ? AppColors.blue : AppColors.grey400,
          width: 2,
        ),
      ),
      child: value
          ? Icon(
              isIOS ? CupertinoIcons.checkmark : Icons.check,
              color: Colors.white,
              size: 16,
            )
          : null,
    ),
  );
}
