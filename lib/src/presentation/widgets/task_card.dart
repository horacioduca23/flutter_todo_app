import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../core/platform/platform_utils.dart';
import '../../domain/task.dart';
import 'circle_check_box.dart';
import 'task_label.dart';
import 'user_assigned_widget.dart';

class TaskCard extends StatelessWidget {
  final VoidCallback? onDismissed;
  final VoidCallback? onTap;
  final VoidCallback? onToggleCompleted;
  final Task task;

  const TaskCard({
    super.key,
    this.onDismissed,
    this.onTap,
    this.onToggleCompleted,
    required this.task,
  });

  @override
  Widget build(BuildContext context) => Dismissible(
    direction: DismissDirection.endToStart,
    key: Key(task.id),
    background: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.red,
      ),
      padding: const EdgeInsets.only(right: 16.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Icon(
          isIOS ? CupertinoIcons.delete_solid : Icons.delete_forever_outlined,
          size: 28.0,
        ),
      ),
    ),
    onDismissed: (_) => onDismissed?.call(),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: task.isCompleted
              ? const Color(0xFF8B9FE8).withValues(alpha: 0.7)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleCheckBox(
              value: task.isCompleted,
              onTap: onToggleCompleted ?? () {},
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: task.isCompleted ? Colors.white : Colors.black,
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    task.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: task.isCompleted
                          ? Colors.white.withValues(alpha: 0.8)
                          : Colors.grey[600],
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (task.label != null) ...[
                  TaskLabel(label: task.labelEnum),
                  const SizedBox(height: 4),
                ],
                if (task.userAssigned.isNotEmpty) ...[
                  UserAssignedWidget(
                    userAssigned: task.userAssigned,
                    isCompleted: task.isCompleted,
                  ),
                  const SizedBox(height: 4),
                ],
                Text(
                  task.statusEnum.label,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: task.isCompleted
                        ? Colors.white.withValues(alpha: 0.7)
                        : AppColors.grey400,
                    fontSize: 14,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
