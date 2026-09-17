import 'package:code/core/route/app_routes.dart';
import 'package:code/core/util/helper_method.dart';
import 'package:code/features/cart/bloc/cart_bloc.dart';
import 'package:code/features/cart/bloc/cart_event.dart';
import 'package:code/features/cart/bloc/cart_state.dart';
import 'package:code/features/cart/cart_item.dart';
import 'package:code/features/cart/price_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final double deliveryFee = 80;

  @override
  void initState() {
    super.initState();

    context.read<CartBloc>().add(LoadCartEvent());
  }

  double calculateSubtotal(List<dynamic> items) {
    double subtotal = 0;

    for (final item in items) {
      subtotal += item.price * item.quantity;
    }

    return subtotal;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,

      // =========================================================
      // APP BAR
      // =========================================================
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        elevation: 0,

        actions: [
          TextButton(
            onPressed: () {
              // Edit cart
            },
            child: Text(
              'Edit',
              style: TextStyle(
                color: colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),

      // =========================================================
      // CART
      // =========================================================
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },

        builder: (context, state) {
          // =====================================================
          // LOADING
          // =====================================================

          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // =====================================================
          // ERROR
          // =====================================================

          if (state is CartError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 50,
                      color: colorScheme.error,
                    ),

                    const SizedBox(height: 12),

                    Text(
                      'Something went wrong',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(state.message, textAlign: TextAlign.center),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () {
                        context.read<CartBloc>().add(LoadCartEvent());
                      },
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              ),
            );
          }

          // =====================================================
          // CART LOADED
          // =====================================================

          if (state is CartLoaded) {
            final items = state.items;

            // ===================================================
            // EMPTY CART
            // ===================================================

            if (items.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 70,
                      color: colorScheme.onSurface.withOpacity(0.4),
                    ),

                    const SizedBox(height: 16),

                    Text(
                      'Your Cart is Empty',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Add some products to your cart.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              );
            }

            // ===================================================
            // PRICE CALCULATION
            // ===================================================

            final double subtotal = calculateSubtotal(items);

            final double total = subtotal + deliveryFee;

            // ===================================================
            // LOADED CART UI
            // ===================================================

            return Column(
              children: [
                // =================================================
                // CART ITEMS
                // =================================================
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),

                    itemCount: items.length,

                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10);
                    },

                    itemBuilder: (context, index) {
                      final item = items[index];

                      return CartItem(
                        image: item.image,
                        name: item.name,
                        price: item.price,
                        quantity: item.quantity,
                        // =========================================
                        // DECREASE
                        // =========================================
                        onDecrease: () {

                          if (item.quantity > 1) {
                        context.read<CartBloc>().add(DecreaseQuantityEvent(cartItemId:item.id!, quantity:item.quantity));
                        HelperMethod.show_toast('Decrease');
                          }
                        },

                        // =========================================
                        // INCREASE
                        // =========================================
                        onIncrease: () {
                          context.read<CartBloc>().add(IncreaseQuantityEvent(cartItemId: item.id!, quantity: item.quantity));
                         HelperMethod.show_toast('Inscrease');
                          },

                        // =========================================
                        // DELETE
                        // =========================================
                        onDelete: () {
                         context.read<CartBloc>().add(DeleteCartItemEvent(cartItemId:item.id!));
                         HelperMethod.show_toast('delete');
                        },
                      );
                    },
                  ),
                ),

                // =================================================
                // PRICE SUMMARY
                // =================================================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      PriceRow(title: 'Subtotal', value: subtotal),

                      const SizedBox(height: 10),

                      PriceRow(title: 'Delivery Fee', value: deliveryFee),

                      const SizedBox(height: 12),

                      Divider(color: colorScheme.onSurface.withOpacity(0.10)),

                      const SizedBox(height: 4),

                      // =========================================
                      // TOTAL
                      // =========================================
                      Row(
                        children: [
                          Text(
                            'Total',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                          ),

                          const Spacer(),

                          Text(
                            'Rs. ${total.toInt()}',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),
                    ],
                  ),
                ),

                // =================================================
                // CHECKOUT BUTTON
                // =================================================
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.checkout);
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        elevation: 0,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      child: Text(
                        'Proceed to Checkout',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          // =====================================================
          // INITIAL / UNKNOWN STATE
          // =====================================================

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
