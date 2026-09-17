import 'package:code/features/cart/smal_lquantity_button.dart';
import 'package:flutter/material.dart';
class CartItem extends StatelessWidget {
  final String image;
  final String name;
  final double price;
  final int quantity;

  final VoidCallback onDecrease;
  final VoidCallback onIncrease;
  final VoidCallback onDelete;

  const CartItem({
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final itemTotal = price * quantity;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: colorScheme.onSurface.withOpacity(.08),
        ),
      ),
      child: Row(
        children: [

          // =========================================================
          // IMAGE
          // =========================================================

          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              image,
              width: 54,
              height: 54,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 54,
                  height: 54,
                  color: colorScheme.onSurface.withOpacity(.05),
                  child: Icon(
                    Icons.fastfood,
                    color: colorScheme.primary,
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 8),

          // =========================================================
          // NAME + PRICE + QUANTITY
          // =========================================================

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  'Rs. ${price.toInt()}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 5),

                // Quantity
                Row(
                  children: [

                    SmallQuantityButton(
                      icon: Icons.remove,
                      onTap: onDecrease,
                    ),

                    SizedBox(
                      width: 28,
                      child: Center(
                        child: Text(
                          '$quantity',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    SmallQuantityButton(
                      icon: Icons.add,
                      onTap: onIncrease,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // =========================================================
          // TOTAL + DELETE
          // =========================================================

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [

              IconButton(
                onPressed: onDelete,
                icon: Icon(
                  Icons.delete_outline,
                  size: 18,
                  color: colorScheme.onSurface.withOpacity(.55),
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 28,
                  minHeight: 28,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                'Rs. ${itemTotal.toInt()}',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}