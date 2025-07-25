import 'package:flutter/material.dart';

class UserAssignedWidget extends StatelessWidget {
  final String userAssigned;
  final bool isCompleted;

  const UserAssignedWidget({
    super.key,
    required this.userAssigned,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.person_outline,
          size: 14,
          color: isCompleted
              ? Colors.white.withValues(alpha: 0.7)
              : Colors.grey[600],
        ),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            userAssigned,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isCompleted
                  ? Colors.white.withValues(alpha: 0.7)
                  : Colors.grey[600],
              fontSize: 11,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
