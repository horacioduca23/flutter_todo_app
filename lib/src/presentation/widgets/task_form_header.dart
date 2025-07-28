import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class TaskFormHeader extends StatelessWidget {
  const TaskFormHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: AppColors.grey300)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Expanded(child: Container(height: 1, color: AppColors.grey300)),
      ],
    );
  }
}
