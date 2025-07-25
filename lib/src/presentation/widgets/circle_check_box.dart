import 'package:flutter/material.dart';

class CircleCheckBox extends StatelessWidget {
  final bool value;
  final VoidCallback onTap;

  const CircleCheckBox({super.key, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: value ? const Color(0xFF4A6CF7) : Colors.transparent,
          border: Border.all(
            color: value ? const Color(0xFF4A6CF7) : Colors.grey[400]!,
            width: 2,
          ),
        ),
        child: value
            ? const Icon(Icons.check, color: Colors.white, size: 16)
            : null,
      ),
    );
  }
}
