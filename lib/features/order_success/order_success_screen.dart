import 'package:flutter/material.dart';
class OrderSuccessScreen extends StatelessWidget {
  final String orderId;

  const OrderSuccessScreen({
    super.key,
    required this.orderId,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [

                // =================================================
                // SUCCESS ICON
                // =================================================

                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.shade600,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 25,
                  ),
                ),

                const SizedBox(height: 12),

                // =================================================
                // DELIVERY IMAGE
                // =================================================

                SizedBox(
                  width: double.infinity,
                  height: 250,

                  child: Image.asset(
                    'assets/png/images/delivery_boy.png',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.delivery_dining,
                        size: 100,
                        color: colorScheme.primary,
                      );
                    },
                  ),
                ),

                const SizedBox(height: 8),

                // =================================================
                // ORDER PLACED
                // =================================================

                Text(
                  'Order Placed!',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  'Your order has been placed\nsuccessfully.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.4,
                    color: colorScheme.onSurface,
                  ),
                ),

                const SizedBox(height: 18),

                // =================================================
                // ORDER INFORMATION CARD
                // =================================================

                Container(
                  width: 180,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: colorScheme.onSurface.withOpacity(.12),
                    ),
                  ),
                  child: Column(
                    children: [

                      Text(
                        'Order #$orderId',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Divider(
                        height: 1,
                        color: colorScheme.onSurface.withOpacity(.10),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Estimated delivery',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),

                      const SizedBox(height: 2),

                      Text(
                        '30 - 45 mins',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // =================================================
                // TRACK ORDER
                // =================================================

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/home',
                              (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      child: Text(
                        'Go to Home',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // =================================================
                // GO TO HOME
                // =================================================

                // TextButton(
                //   onPressed: () {
                //     Navigator.pushNamedAndRemoveUntil(
                //       context,
                //       '/home',
                //           (route) => false,
                //     );
                //   },
                //   child: Text(
                //     'Go to Home',
                //     style: theme.textTheme.bodyMedium?.copyWith(
                //       color: colorScheme.onSurface,
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}