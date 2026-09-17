import 'package:flutter/material.dart';
class SmallQuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const SmallQuantityButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.onSurface.withOpacity(.06),
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(5),
        child: SizedBox(
          width: 22,
          height: 22,
          child: Icon(
            icon,
            size: 14,
            color: colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}