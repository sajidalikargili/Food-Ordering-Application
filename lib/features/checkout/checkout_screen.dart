import 'package:code/core/route/app_routes.dart';
import 'package:code/features/cart/bloc/cart_bloc.dart';
import 'package:code/features/cart/bloc/cart_event.dart';
import 'package:code/features/cart/bloc/cart_state.dart';
import 'package:code/features/cart/service/cart_service.dart';
import 'package:code/features/checkout/order_item.dart';
import 'package:code/features/checkout/payment_option.dart';
import 'package:code/features/checkout/price_row.dart';
import 'package:code/features/order_success/model/order_model.dart';
import 'package:code/features/order_success/service/order_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final orderService =OrderService;
  final cartService=CartService;
  String selectedPayment = 'cash';

  final String address = 'Main Street, Skardu, Pakistan';

  final double deliveryFee = 80;

  double calculateSubtotal(List items) {
    return items.fold(
      0.0,
          (sum, item) => sum + item.totalPrice,
    );
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
        backgroundColor: colorScheme.surface,
        elevation: 0,
        centerTitle: true,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: colorScheme.onSurface,
          ),
        ),

        title: Text(
          'Checkout',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
      ),

      // =========================================================
      // BODY
      // =========================================================

      body: SafeArea(
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {

            if (state is CartLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CartError) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(
                    color: colorScheme.error,
                  ),
                ),
              );
            }

            // =====================================================
            // CART LOADED
            // =====================================================

            if (state is CartLoaded) {
              final items = state.items;

              // If cart is empty
              if (items.isEmpty) {
                return Center(
                  child: Text(
                    'Your cart is empty',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                );
              }

              // Calculate subtotal from real cart items
              final subtotal = calculateSubtotal(items);

              final total = subtotal + deliveryFee;

              return Column(
                children: [
                  // =================================================
                  // SCROLLABLE CONTENT
                  // =================================================

                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          // =========================================
                          // DELIVERY ADDRESS
                          // =========================================
                          Text(
                            'Delivery Address',
                            style:
                            theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: colorScheme.surface,
                              borderRadius:
                              BorderRadius.circular(10),
                              border: Border.all(
                                color: colorScheme.onSurface
                                    .withOpacity(.10),
                              ),
                            ),
                            child: Row(
                              children: [

                                Container(
                                  width: 34,
                                  height: 34,
                                  decoration: BoxDecoration(
                                    color: colorScheme.primary
                                        .withOpacity(.08),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.home_outlined,
                                    size: 19,
                                    color: colorScheme.primary,
                                  ),
                                ),

                                const SizedBox(width: 10),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [

                                      Text(
                                        'Home',
                                        style: theme
                                            .textTheme.bodySmall
                                            ?.copyWith(
                                          fontWeight:
                                          FontWeight.w600,
                                          color:
                                          colorScheme.onSurface,
                                        ),
                                      ),

                                      const SizedBox(height: 3),

                                      Text(
                                        address,
                                        maxLines: 1,
                                        overflow:
                                        TextOverflow.ellipsis,
                                        style: theme
                                            .textTheme.labelSmall
                                            ?.copyWith(
                                          color: colorScheme
                                              .onSurface
                                              .withOpacity(.60),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                TextButton(
                                  onPressed: () {
                                    // Change address later
                                  },
                                  child: Text(
                                    'Change',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color:
                                      colorScheme.primary,
                                      fontWeight:
                                      FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 18),

                          // =========================================
                          // ORDER SUMMARY
                          // =========================================

                          Text(
                            'Order Summary',
                            style:
                            theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                          ),

                          const SizedBox(height: 8),

                          // =========================================
                          // REAL CART ITEMS
                          // =========================================

                          ...items.map(
                                (item) {
                              return Padding(
                                padding:
                                const EdgeInsets.only(
                                  bottom: 8,
                                ),
                                child: OrderItem(
                                  name: item.name,
                                  quantity: item.quantity,
                                  price: item.totalPrice,
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 10),

                          Divider(
                            color: colorScheme.onSurface
                                .withOpacity(.10),
                          ),

                          const SizedBox(height: 8),

                          // =========================================
                          // SUBTOTAL
                          // =========================================

                          PriceRow(
                            title: 'Subtotal',
                            price: subtotal,
                          ),

                          const SizedBox(height: 10),

                          // =========================================
                          // DELIVERY FEE
                          // =========================================

                          PriceRow(
                            title: 'Delivery Fee',
                            price: deliveryFee,
                          ),

                          const SizedBox(height: 12),

                          Divider(
                            height: 1,
                            color: colorScheme.onSurface
                                .withOpacity(.10),
                          ),

                          const SizedBox(height: 12),

                          // =========================================
                          // TOTAL
                          // =========================================

                          Row(
                            children: [

                              Text(
                                'Total',
                                style: theme
                                    .textTheme.titleMedium
                                    ?.copyWith(
                                  fontWeight:
                                  FontWeight.bold,
                                  color:
                                  colorScheme.onSurface,
                                ),
                              ),

                              const Spacer(),

                              Text(
                                'Rs. ${total.toInt()}',
                                style: theme
                                    .textTheme.titleMedium
                                    ?.copyWith(
                                  fontWeight:
                                  FontWeight.bold,
                                  color:
                                  colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          // =========================================
                          // PAYMENT METHOD
                          // =========================================

                          Text(
                            'Payment Method',
                            style:
                            theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Container(
                            decoration: BoxDecoration(
                              color: colorScheme.surface,
                              borderRadius:
                              BorderRadius.circular(10),
                              border: Border.all(
                                color: colorScheme.onSurface
                                    .withOpacity(.10),
                              ),
                            ),
                            child: Column(
                              children: [

                                PaymentOption(
                                  title: 'Cash on Delivery',
                                  icon: Icons.circle_outlined,
                                  value: 'cash',
                                  groupValue:
                                  selectedPayment,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedPayment =
                                      value!;
                                    });
                                  },
                                ),

                                Divider(
                                  height: 1,
                                  color: colorScheme.onSurface
                                      .withOpacity(.08),
                                ),

                                PaymentOption(
                                  title: 'Card',
                                  icon:
                                  Icons.credit_card_outlined,
                                  value: 'card',
                                  groupValue:
                                  selectedPayment,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedPayment =
                                      value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),

                  // =================================================
                  // PLACE ORDER BUTTON
                  // =================================================

                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      8,
                      8,
                      8,
                      12,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          // 1. Get cart items from CartBloc
                          final cartState = context.read<CartBloc>().state;

                          if (cartState is! CartLoaded) {
                            return;
                          }

                          final items = cartState.items;

                          // 2. Convert cart items to order items
                          final orderItems = items.map((item) {
                            return {
                              'productId': item.productId,
                              'name': item.name,
                              'image': item.image,
                              'price': item.price,
                              'quantity': item.quantity,
                              'extras': item.extras.map((extra) {
                                return {
                                  'name': extra.name,
                                  'price': extra.price,
                                };
                              }).toList(),
                              'totalPrice': item.totalPrice,
                            };
                          }).toList();

                          // 3. Create order
                          final order = OrderModel(
                            userId: FirebaseAuth.instance.currentUser!.uid,
                            items: orderItems,
                            subtotal: subtotal,
                            deliveryFee: deliveryFee,
                            total: total,
                            address: address,
                            paymentMethod: selectedPayment,
                            status: 'confirmed',
                          );

                          // 4. Save to Firebase
                          final orderId = await OrderService().createOrder(order);
                          // 5. Only after Firebase succeeds, go to success screen
                          if (!context.mounted) return;
                          context.read<CartBloc>().add(ClearCartEvent());
                          Navigator.pushNamed(
                            context,
                            AppRoutes.order_success,
                            arguments: orderId,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          colorScheme.primary,
                          foregroundColor:
                          colorScheme.onPrimary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Place Order',
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(
                            color:
                            colorScheme.onPrimary,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}