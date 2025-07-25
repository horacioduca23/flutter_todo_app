import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/platform/platform_utils.dart';

class AdaptiveDialogAlert extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  const AdaptiveDialogAlert({
    super.key,
    required this.title,
    required this.content,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    if (isIOS) {
      return CupertinoAlertDialog(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        content: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(content, style: const TextStyle(fontSize: 16)),
        ),
        actions: actions,
      );
    }
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      content: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(content, style: const TextStyle(fontSize: 16)),
      ),
      actions: actions,
    );
  }
}
