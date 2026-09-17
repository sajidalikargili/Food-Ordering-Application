import 'package:flutter/material.dart';
class PaymentOption extends StatelessWidget {
  final String title;
  final String value;
  final String groupValue;
  final IconData icon;
  final ValueChanged<String?> onChanged;

  const PaymentOption({
    required this.title,
    required this.value,
    required this.groupValue,
    required this.icon,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final bool selected = value == groupValue;

    return InkWell(
      onTap: () => onChanged(value),
      child: SizedBox(
        height: 48,
        child: Row(
          children: [

            const SizedBox(width: 8),

            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              size: 18,
              color: selected
                  ? colorScheme.primary
                  : colorScheme.onSurface.withOpacity(.45),
            ),

            const SizedBox(width: 10),

            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}