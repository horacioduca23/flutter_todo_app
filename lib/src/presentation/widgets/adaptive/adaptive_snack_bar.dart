import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/platform/platform_utils.dart';

class AdaptiveSnackBar {
  static void showAndNavigate(
    BuildContext context, {
    required String message,
    Color? backgroundColor,
    required VoidCallback onNavigate,
  }) {
    if (isIOS) {
      _showCupertinoSnackBarAndNavigate(
        context,
        message: message,
        backgroundColor: backgroundColor,
        onNavigate: onNavigate,
      );
    } else {
      _showMaterialSnackBar(
        context,
        message: message,
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 4),
      );
      onNavigate();
    }
  }

  static void _showMaterialSnackBar(
    BuildContext context, {
    required String message,
    Color? backgroundColor,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: duration ?? const Duration(seconds: 4),
      ),
    );
  }

  static void _showCupertinoSnackBarAndNavigate(
    BuildContext context, {
    required String message,
    Color? backgroundColor,
    required VoidCallback onNavigate,
  }) {
    final overlay = Overlay.of(context);
    final OverlayEntry? overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 20,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: backgroundColor ?? CupertinoColors.systemGreen,
              borderRadius: BorderRadius.circular(8),
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
                Icon(
                  CupertinoIcons.check_mark_circled_solid,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    onNavigate();

    Future.delayed(const Duration(seconds: 4), () => overlayEntry?.remove());
  }
}
