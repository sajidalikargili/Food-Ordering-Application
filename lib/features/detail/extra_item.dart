import 'package:flutter/material.dart';
class ExtraItem extends StatelessWidget {
  final String title;
  final double price;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const ExtraItem({
    required this.title,
    required this.price,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      height: 32,
      child: Row(
        children: [

          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: colorScheme.primary,
            materialTapTargetSize:
            MaterialTapTargetSize.shrinkWrap,
          ),

          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),

          const Spacer(),

          Text(
            '+  Rs. ${price.toInt()}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}