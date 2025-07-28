import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../domain/enum/task_label_enum.dart';

class TaskLabel extends StatelessWidget {
  const TaskLabel({super.key, required this.label});

  final TaskLabelEnum label;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = switch (label) {
      TaskLabelEnum.work => AppColors.work,
      TaskLabelEnum.personal => AppColors.personal,
      TaskLabelEnum.urgent => AppColors.urgent,
      TaskLabelEnum.home => AppColors.home,
      TaskLabelEnum.projects => AppColors.projects,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        label.label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}
