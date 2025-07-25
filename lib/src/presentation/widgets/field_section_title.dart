import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FieldSectionTitle extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry? margin;

  const FieldSectionTitle({super.key, required this.title, this.margin});

  @override
  Widget build(BuildContext context) {
    final bool isIOS = defaultTargetPlatform == TargetPlatform.iOS;
    final ThemeData theme = Theme.of(context);
    return Container(
      alignment: Alignment.centerLeft,
      margin: margin ?? const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: isIOS ? 17 : 16,
          color: isIOS ? Colors.blueGrey[800] : Colors.black87,
          letterSpacing: 0.1,
        ),
      ),
    );
  }
}
