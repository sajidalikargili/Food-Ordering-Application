import 'package:code/core/constant/app_colors.dart';
import 'package:code/core/route/app_routes.dart';
import 'package:code/features/home/presentation/bloc/category_bloc.dart';
import 'package:code/features/home/presentation/bloc/category_state.dart';
import 'package:code/features/product/presentation/bloc/product_bloc.dart';
import 'package:code/features/product/presentation/bloc/product_event.dart';
import 'package:code/features/product/presentation/bloc/product_state.dart';
import 'package:code/features/product/presentation/screen/product_list_screen.dart';
import 'package:code/features/theme/bloc/theme_bloc.dart';
import 'package:code/features/theme/bloc/theme_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProductBloc>().add(getPopularProductEvent());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // =====================================================
              // LOCATION + NOTIFICATION
              // =====================================================

              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
                child: Row(
                  children: [

                    Icon(
                      Icons.location_on,
                      color: colorScheme.primary,
                      size: 21,
                    ),

                    const SizedBox(width: 6),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            'Deliver to',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: colorScheme.onSurface.withOpacity(.65),
                            ),
                          ),

                          const SizedBox(height: 2),

                          Row(
                            children: [

                              Text(
                                'Home - Main Street, Skardu',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: colorScheme.onSurface,
                                ),
                              ),

                              const SizedBox(width: 3),

                              Icon(
                                Icons.keyboard_arrow_down,
                                size: 17,
                                color: colorScheme.onSurface,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        context.read<ThemeBloc>().add(ThemeToggleEvent());
                      },
                      icon: Icon(
                        Icons.notifications_none_rounded,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),

              // =====================================================
              // SEARCH
              // =====================================================

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: colorScheme.onSurface.withOpacity(.06),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for food, restaurants...',
                      hintStyle: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withOpacity(.45),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 21,
                        color: colorScheme.onSurface.withOpacity(.5),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // =====================================================
              // OFFER BANNER
              // =====================================================

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(
                          left: 14,
                          top: 9,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              'Get 20% OFF',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 1),

                            Text(
                              'On your first order',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: colorScheme.onPrimary.withOpacity(.9),
                              ),
                            ),

                            const SizedBox(height: 18),

                            SizedBox(
                              height: 23,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: colorScheme.onPrimary,
                                  foregroundColor: colorScheme.primary,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: const Text(
                                  'Order Now',
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Positioned(
                        right: 5,
                        top: 4,
                        bottom: 4,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20,right: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/jpg/images/burger_image.jpg',
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) {
                                  return Container(
                                    width: 120,
                                    color: colorScheme.primary,
                                    child: Icon(
                                      Icons.local_pizza,
                                      size: 55,
                                      color: colorScheme.onPrimary,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // =====================================================
              // CATEGORIES TITLE
              // =====================================================

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Row(
                  children: [

                    Text(
                      'Categories',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    const Spacer(),

                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'See all',
                        style: TextStyle(
                          color: colorScheme.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // =====================================================
              // CATEGORIES LIST
              // =====================================================
             BlocBuilder<CategoryBloc,CategoryState>(builder:(context,state){
               if(state is CategoryLoading){
                 return Center(
                   child: CircularProgressIndicator(),
                 );
               }
               if (state is CategoryError){
                 return Center(
                   child: Text(state.message),
                 );
               }
               if (state is CategorySuccess){
                 final categories=state.categoryList;
                 return SizedBox(
                   height: 82,
                   child: ListView.builder(
                     scrollDirection: Axis.horizontal,
                     padding: const EdgeInsets.symmetric(horizontal: 6),
                     itemCount: categories.length,
                     itemBuilder: (context, index) {

                       final category = categories[index];

                       return GestureDetector(
                         onTap: () {
                           context.read<ProductBloc>().add(getProductByCategoryEvent(categoryId: category.id));
                           // Navigator.push(context, MaterialPageRoute(builder: (_){
                           //   return ProductListScreen(productName: category.name);
                           // }));
                            Navigator.pushNamed(context, AppRoutes.product,arguments: category.name);
                            print(
                             'Selected category id and name: ${category.id},${category.name}',
                           );
                         },
                         child: Container(
                           width: 60,
                           margin: const EdgeInsets.only(right: 10),

                           child: Column(
                             children: [

                               Container(
                                 decoration: BoxDecoration(
                                   color: colorScheme.surface,
                                   borderRadius: BorderRadius.circular(10),
                                   border: Border.all(
                                     color: colorScheme.onSurface.withOpacity(.08),
                                   ),
                                   boxShadow: [
                                     BoxShadow(
                                       color: Colors.black.withOpacity(
                                         theme.brightness == Brightness.dark
                                             ? .12
                                             : .05,
                                       ),
                                       blurRadius: 5,
                                       offset: const Offset(0, 2),
                                     ),
                                   ],
                                 ),
                                 child: ClipRRect(
                                   borderRadius: BorderRadius.circular(10),
                                   child: Image.network(
                                     category.image,
                                     fit: BoxFit.cover,
                                     width: 55,
                                     height: 55,
                                     errorBuilder: (_, __, ___) {
                                       return Icon(
                                         Icons.fastfood,
                                         color: colorScheme.primary,
                                       );
                                     },
                                   ),
                                 ),
                               ),

                               const SizedBox(height: 5),

                               Text(
                                 category.name,
                                 maxLines: 1,
                                 overflow: TextOverflow.ellipsis,
                                 style: theme.textTheme.labelSmall?.copyWith(
                                   fontSize: 10,
                                   color: colorScheme.onSurface,
                                 ),
                               ),
                             ],
                           ),
                         ),
                       );
                     },
                   ),
                 );
               }
               return const SizedBox();

             }),


              const SizedBox(height: 8),

              // =====================================================
              // POPULAR TITLE
              // =====================================================

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Row(
                  children: [

                    Text(
                      'Popular Near You',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    const Spacer(),

                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'See all',
                        style: TextStyle(
                          color: colorScheme.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // =====================================================
              // POPULAR PRODUCTS
              // =====================================================
            BlocBuilder<ProductBloc,ProductState>(builder: (context,state){
              if(state is PopularProductLoading){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if( state is PopularProductError ){
                return Center(
                  child: Text(state.message),
                );
              }
              if(state is PopularProductSuccess){
                 return  SizedBox(
                   height: 185,
                   child: ListView.builder(
                     scrollDirection: Axis.horizontal,
                     padding: const EdgeInsets.symmetric(horizontal: 6),
                     itemCount: state.popularProductList.length,
                     itemBuilder: (context, index) {

                       final product = state.popularProductList[index];

                       return InkWell(
                         onTap: (){
                           Navigator.pushNamed(
                             context,
                             AppRoutes.detail,
                             arguments: product,
                           );
                         },
                         child: Container(
                           width: 175,
                           margin: const EdgeInsets.only(right: 10),
                           decoration: BoxDecoration(
                             color: colorScheme.surface,
                             borderRadius: BorderRadius.circular(10),
                             border: Border.all(
                               color: colorScheme.onSurface.withOpacity(.08),
                             ),
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.black.withOpacity(
                                   theme.brightness == Brightness.dark
                                       ? .12
                                       : .05,
                                 ),
                                 blurRadius: 5,
                                 offset: const Offset(0, 2),
                               ),
                             ],
                           ),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [

                               // Image
                               Stack(
                                 children: [

                                   ClipRRect(
                                     borderRadius: const BorderRadius.vertical(
                                       top: Radius.circular(10),
                                     ),
                                     child: Image.network(
                                       product.image,
                                       height: 105,
                                       width: double.infinity,
                                       fit: BoxFit.cover,
                                       errorBuilder: (_, __, ___) {
                                         return Container(
                                           height: 105,
                                           color: colorScheme.onSurface
                                               .withOpacity(.05),
                                           child: Icon(
                                             Icons.fastfood,
                                             size: 40,
                                             color: colorScheme.primary,
                                           ),
                                         );
                                       },
                                     ),
                                   ),

                                   Positioned(
                                     right: 7,
                                     top: 7,
                                     child: Icon(
                                       Icons.favorite_border,
                                       size: 15,
                                       color: colorScheme.onSurface,
                                     ),
                                   ),
                                 ],
                               ),

                               Padding(
                                 padding: const EdgeInsets.fromLTRB(
                                   8,
                                   6,
                                   8,
                                   4,
                                 ),
                                 child: Text(
                                   product.name,
                                   style: theme.textTheme.bodySmall?.copyWith(
                                     fontWeight: FontWeight.w600,
                                     color: colorScheme.onSurface,
                                   ),
                                 ),
                               ),

                               Padding(
                                 padding: const EdgeInsets.symmetric(
                                   horizontal: 8,
                                 ),
                                 child: Row(
                                   children: [

                                     Text(
                                       product.price.toString(),
                                       style: theme.textTheme.bodySmall?.copyWith(
                                         fontWeight: FontWeight.bold,
                                         color: colorScheme.onSurface,
                                       ),
                                     ),

                                     const Spacer(),

                                     Icon(
                                       Icons.star,
                                       size: 14,
                                       color: AppColors.accent,
                                     ),

                                     const SizedBox(width: 2),

                                     Text(
                                       product.rating.toString(),
                                       style: theme.textTheme.labelSmall?.copyWith(
                                         color: colorScheme.onSurface,
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                             ],
                           ),
                         ),
                       );
                     },
                   ),
                 );

              }
              return SizedBox();

            }),

            ],
          ),
        ),
      ),

    );
  }
}