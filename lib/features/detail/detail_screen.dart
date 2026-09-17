import 'package:code/core/route/app_routes.dart';
import 'package:code/features/cart/model/cart_item_model.dart';
import 'package:code/features/cart/service/cart_service.dart';
import 'package:code/features/detail/circle_button.dart';
import 'package:code/features/detail/extra_item.dart';
import 'package:code/features/detail/model/extra_model.dart';
import 'package:code/features/detail/quantity_button.dart';
import 'package:code/features/product/data/model/product_model.dart';
import 'package:flutter/material.dart';
class DetailScreen extends StatefulWidget {
 ProductModel productModel;
 DetailScreen({super.key, required this.productModel});
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int quantity = 1;
  List<ExtraModel> selectedExtras = [];
  bool cheese = false;
  bool extraSauce = false;
  bool fries = false;


  final List<ExtraModel> extras = [
    ExtraModel(
      name: 'Cheese',
      price: 50,
    ),
    ExtraModel(
      name: 'Extra Sauce',
      price: 30,
    ),
    ExtraModel(
      name: 'Fries',
      price: 100,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    bool isSelected=false;

    return Scaffold(
        backgroundColor: colorScheme.surface,

        body: SafeArea(
          child: Column(
            children: [

              // =====================================================
              // MAIN CONTENT
              // =====================================================

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // =================================================
                      // PRODUCT IMAGE
                      // =================================================

                      Stack(
                        children: [

                          SizedBox(
                            width: double.infinity,
                            height: 220,
                            child: Image.network(
                              widget.productModel.image,
                              fit: BoxFit.cover,
                            ),
                          ),

                          // Dark gradient at top
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 70,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black.withOpacity(.35),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // Back button
                          Positioned(
                            left: 10,
                            top: 10,
                            child: CircleButton(
                              icon: Icons.arrow_back,
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),

                          // Favorite button
                          Positioned(
                            right: 10,
                            top: 10,
                            child: CircleButton(
                              icon: Icons.favorite_border,
                              iconColor: colorScheme.primary,
                              onTap: () {
                                // Add favorite functionality
                              },
                            ),
                          ),
                        ],
                      ),

                      // =================================================
                      // PRODUCT INFORMATION
                      // =================================================

                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          10,
                          12,
                          10,
                          20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            // Product name + rating
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                Expanded(
                                  child: Text(
                                    widget.productModel.name,
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: colorScheme.onSurface,
                                    ),
                                  ),
                                ),

                                Icon(
                                  Icons.star,
                                  color: colorScheme.secondary,
                                  size: 16,
                                ),

                                const SizedBox(width: 3),

                                Text(
                                  widget.productModel.rating.toString(),
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.onSurface,
                                  ),
                                ),

                                const SizedBox(width: 4),

                                Text(
                                  '(120 Reviews)',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: colorScheme.onSurface
                                        .withOpacity(.55),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            // Price
                            Text(
                              widget.productModel.price.toString(),
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                            ),

                            const SizedBox(height: 8),

                            // Description
                            Text(
                              widget.productModel.description,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                height: 1.4,
                                color: colorScheme.onSurface.withOpacity(.65),
                              ),
                            ),

                            const SizedBox(height: 18),

                            // =================================================
                            // QUANTITY
                            // =================================================

                            Row(
                              children: [

                                Text(
                                  'Quantity',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.onSurface,
                                  ),
                                ),

                                const Spacer(),

                                Container(
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: colorScheme.onSurface
                                        .withOpacity(.06),
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                  child: Row(
                                    children: [

                                      QuantityButton(
                                        icon: Icons.remove,
                                        onTap: () {
                                          if (quantity > 1) {
                                            setState(() {
                                              quantity--;
                                            });
                                          }
                                        },
                                      ),

                                      SizedBox(
                                        width: 42,
                                        child: Center(
                                          child: Text(
                                            '$quantity',
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: colorScheme.onSurface,
                                            ),
                                          ),
                                        ),
                                      ),

                                      QuantityButton(
                                        icon: Icons.add,
                                        onTap: () {
                                          setState(() {
                                            quantity++;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 18),

                            // =================================================
                            // EXTRAS
                            // =================================================

                            Text(
                              'Extras',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                            ),

                            const SizedBox(height: 5),

                            // Cheese
                        SizedBox(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: extras.length,
                            itemBuilder: (context, index) {
                              final item = extras[index];
                              final isSelected=selectedExtras.any(
                                  (extras)=>extras.name==item.name
                              );
                              return ExtraItem(
                                title: item.name,
                                price: item.price,
                                value: isSelected,
                                onChanged: (value) {
                                  setState(() {
                                 if(value==true){
                                   selectedExtras.add(item);
                                 }else{
                                   selectedExtras.remove(item);
                                 }
                                  });
                                },
                              );
                            },
                          ),
                        ),

                            // Extra sauce
                            // ExtraItem(
                            //   title: 'Extra Sauce',
                            //   price: saucePrice,
                            //   value: extraSauce,
                            //   onChanged: (value) {
                            //     setState(() {
                            //       extraSauce = value ?? false;
                            //     });
                            //   },
                            // ),
                            //
                            // // Fries
                            // ExtraItem(
                            //   title: 'Fries',
                            //   price: friesPrice,
                            //   value: fries,
                            //   onChanged: (value) {
                            //     setState(() {
                            //       fries = value ?? false;
                            //     });
                            //   },
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // =========================================================
              // BOTTOM ADD TO CART
              // =========================================================

              Container(
                padding: const EdgeInsets.fromLTRB(
                  8,
                  8,
                  8,
                  10,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  border: Border(
                    top: BorderSide(
                      color: colorScheme.onSurface.withOpacity(.08),
                    ),
                  ),
                ),
                child: Row(
                  children: [

                    // Cart icon button
                    SizedBox(
                      width: 58,
                      height: 45,
                      child: OutlinedButton(
                        onPressed: () {
                          // Open cart
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          side: BorderSide(
                            color: colorScheme.onSurface.withOpacity(.20),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Icon(
                          Icons.shopping_cart_outlined,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    // Add to cart
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              final cartService = CartService();

                              final cartItem = CartItemModel(
                                productId: widget.productModel.id,
                                name: widget.productModel.name,
                                image: widget.productModel.image,
                                price: widget.productModel.price,
                                quantity: quantity,
                                extras: selectedExtras,
                              );

                              // Wait until Firebase finishes saving
                              await cartService.addToCart(cartItem);

                              if (!context.mounted) return;

                              Navigator.pushNamed(
                                context,
                                AppRoutes.cart,
                              );
                            } catch (e) {
                              if (!context.mounted) return;

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e.toString()),
                                ),
                              );
                            }
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
                            'Add to Cart',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )

    );
  }
}
