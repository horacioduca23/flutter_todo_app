import 'package:flutter/material.dart';

class CharacterCounter extends StatelessWidget {
  const CharacterCounter({
    super.key,
    required this.currentLength,
    required this.maxLength,
  });

  final int currentLength;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    final bool isNearLimit = currentLength > maxLength * 0.8;
    final bool isAtLimit = currentLength >= maxLength;

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '$currentLength/$maxLength',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isAtLimit
                  ? Colors.red
                  : isNearLimit
                  ? Colors.orange
                  : Colors.grey[600],
              fontWeight: isAtLimit ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
