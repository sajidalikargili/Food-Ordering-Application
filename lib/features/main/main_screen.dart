import 'package:code/features/cart/cart_screen.dart';
import 'package:code/features/home/presentation/home_screen.dart';
import 'package:code/features/my_order/my_order_screen.dart';
import 'package:code/features/profile/profile_screen.dart';
import 'package:flutter/material.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex=0;
  List<Widget> list_screen=[
    HomeScreen(),
    CartScreen(),
    MyOrderScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        backgroundColor: colorScheme.surface,
        indicatorColor: colorScheme.primary.withOpacity(.12),

        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
              color: colorScheme.onSurface.withOpacity(.65),
            ),
            selectedIcon: Icon(
              Icons.home,
              color: colorScheme.primary,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: colorScheme.onSurface.withOpacity(.65),
            ),
            selectedIcon: Icon(
              Icons.shopping_cart,
              color: colorScheme.primary,
            ),
            label: 'Cart',
          ),

          NavigationDestination(
            icon: Icon(
              Icons.receipt_long_outlined,
              color: colorScheme.onSurface.withOpacity(.65),
            ),
            selectedIcon: Icon(
              Icons.receipt_long,
              color: colorScheme.primary,
            ),
            label: 'Orders',
          ),

          NavigationDestination(
            icon: Icon(
              Icons.person_outline,
              color: colorScheme.onSurface.withOpacity(.65),
            ),
            selectedIcon: Icon(
              Icons.person,
              color: colorScheme.primary,
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: list_screen[currentIndex]
    );
  }
}
