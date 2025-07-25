import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/platform/platform_utils.dart';

class AdaptiveProgressIndicator extends StatelessWidget {
  final double? size;
  final Color? color;

  const AdaptiveProgressIndicator({super.key, this.size, this.color});

  @override
  Widget build(BuildContext context) {
    if (isIOS) {
      return CupertinoActivityIndicator(
        radius: size != null ? size! / 2 : 10.0,
        color: color,
      );
    }
    return CircularProgressIndicator(
      strokeWidth: size != null ? size! / 5 : 4.0,
      color: color,
    );
  }
}
