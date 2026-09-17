import 'package:flutter/material.dart';
class PriceRow extends StatelessWidget {
  final String title;
  final double price;

  const PriceRow({
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [

        Text(
          title,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurface,
          ),
        ),

        const Spacer(),

        Text(
          'Rs. ${price.toInt()}',
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}