
import 'package:code/core/route/app_routes.dart';
import 'package:code/features/cart/cart_screen.dart';
import 'package:code/features/checkout/checkout_screen.dart';
import 'package:code/features/detail/detail_screen.dart';
import 'package:code/features/home/presentation/home_screen.dart';
import 'package:code/features/login/presentation/login_screen.dart';
import 'package:code/features/main/main_screen.dart';
import 'package:code/features/my_order/my_order_screen.dart';
import 'package:code/features/order_success/order_success_screen.dart';
import 'package:code/features/product/data/model/product_model.dart';
import 'package:code/features/product/presentation/screen/product_list_screen.dart';
import 'package:code/features/profile/profile_screen.dart';
import 'package:code/features/register/presentation/register_screen.dart';
import 'package:code/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
class AppPage {
Route<dynamic> generateRoute(RouteSettings setting){
  switch(setting.name){
    case AppRoutes.splash:
      return MaterialPageRoute(builder: (context){
        return SplashScreen();
      });
    case AppRoutes.login:
      return MaterialPageRoute(builder: (context){
        return LoginScreen();
      });
    case AppRoutes.register:
      return MaterialPageRoute(builder: (context){
        return RegisterScreen();
      });
    case AppRoutes.home:
      return MaterialPageRoute(builder: (context){
        return HomeScreen();
      });
    case AppRoutes.main:
      return MaterialPageRoute(builder: (context){
        return MainScreen();
      });
    case AppRoutes.detail:
      return MaterialPageRoute(builder: (context){
        final productModel=setting.arguments as ProductModel;
        return DetailScreen(productModel: productModel);
      });
    case AppRoutes.product:
      return MaterialPageRoute(builder: (context){
        final productName= setting.arguments as String;
        return ProductListScreen(productName: productName);
      });
    case AppRoutes.cart:
      return MaterialPageRoute(builder: (context){
        return CartScreen();
      });
      case AppRoutes.checkout:
    return MaterialPageRoute(builder: (context){
      return CheckoutScreen();
    });
    case AppRoutes.order_success:
    return MaterialPageRoute(builder: (context){
      String orderId=setting.arguments as String;
      return OrderSuccessScreen(orderId: orderId);
    });
    case AppRoutes.my_order:
      return MaterialPageRoute(builder: (context){
        return MyOrderScreen();
      });
    case AppRoutes.profile:
      return MaterialPageRoute(builder: (context){
        return ProfileScreen();
      });
   default:
     return MaterialPageRoute(builder: (context){
       return Center(
         child:Center(
           child:Text("Route donot found")
         ) ,
       );
     });
  }
}
}