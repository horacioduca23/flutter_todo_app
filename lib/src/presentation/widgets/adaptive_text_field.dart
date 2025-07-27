import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/platform/platform_utils.dart';

class AdaptiveTextField extends StatelessWidget {
  const AdaptiveTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.minLines = 1,
    this.maxLines,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.isLarge = false,
    this.onChanged,
    this.maxLength,
    this.showCounter = true,
  });

  final TextEditingController controller;
  final String hintText;
  final int minLines;
  final int? maxLines;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final bool isLarge;
  final void Function(String)? onChanged;
  final int? maxLength;
  final bool showCounter;

  @override
  Widget build(BuildContext context) {
    if (isIOS) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: CupertinoTextField(
          controller: controller,
          placeholder: hintText,
          padding: EdgeInsets.symmetric(
            horizontal: isLarge ? 16 : 8,
            vertical: isLarge ? 20 : 16,
          ),
          prefix: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: prefixIcon,
          ),
          style: TextStyle(
            fontSize: isLarge ? 18 : 16,
            fontWeight: isLarge ? FontWeight.w500 : FontWeight.normal,
          ),
          minLines: minLines,
          maxLines: maxLines,
          maxLength: showCounter ? maxLength : null,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onChanged: onChanged,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: CupertinoColors.systemGrey4, width: 1),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontSize: isLarge ? 18 : 16,
          fontWeight: isLarge ? FontWeight.w500 : FontWeight.normal,
        ),
        maxLength: maxLength,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.grey[500],
            fontSize: isLarge ? 18 : 16,
          ),
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF4A6CF7), width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: isLarge ? 20 : 16,
          ),
          counterText: showCounter ? null : '',
        ),
        onChanged: onChanged,
      ),
    );
  }
}
