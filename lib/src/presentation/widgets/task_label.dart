import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../domain/enum/task_label_enum.dart';

class TaskLabel extends StatelessWidget {
  const TaskLabel({super.key, required this.label});

  final TaskLabelEnum label;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = switch (label) {
      TaskLabelEnum.frontend => AppColors.frontend,
      TaskLabelEnum.backend => AppColors.backend,
      TaskLabelEnum.qa => AppColors.qa,
      TaskLabelEnum.testing => AppColors.testing,
      TaskLabelEnum.otro => AppColors.other,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        label.label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
