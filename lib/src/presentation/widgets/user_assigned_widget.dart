import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class UserAssignedWidget extends StatelessWidget {
  final String userAssigned;
  final bool isCompleted;

  const UserAssignedWidget({
    super.key,
    required this.userAssigned,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        Icons.person_outline,
        size: 17,
        color: isCompleted
            ? Colors.white.withValues(alpha: 0.7)
            : AppColors.grey600,
      ),
      const SizedBox(width: 5),
      Flexible(
        child: Text(
          userAssigned,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: isCompleted
                ? Colors.white.withValues(alpha: 0.7)
                : AppColors.grey600,
            fontSize: 13,
            decoration: TextDecoration.none,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}
