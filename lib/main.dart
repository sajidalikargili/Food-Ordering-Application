import 'package:code/core/constant/app_colors.dart';
import 'package:code/features/cart/bloc/cart_bloc.dart';
import 'package:code/features/cart/bloc/cart_event.dart';
import 'package:code/features/cart/service/cart_service.dart';
import 'package:code/features/home/data/service/category_service.dart';
import 'package:code/features/home/presentation/bloc/category_bloc.dart';
import 'package:code/features/home/presentation/bloc/category_event.dart';
import 'package:code/features/login/data/login_service.dart';
import 'package:code/features/product/data/service/product_service.dart';
import 'package:code/features/product/presentation/bloc/product_bloc.dart';
import 'package:code/features/register/data/bloc/register_bloc.dart';
import 'package:code/features/login/presentation/bloc/login_bloc.dart';
import 'package:code/features/register/data/service/register_service.dart';
import 'package:code/features/splash/splash_screen.dart';
import 'package:code/features/theme/bloc/theme_bloc.dart';
import 'package:code/features/theme/bloc/theme_event.dart';
import 'package:code/features/theme/bloc/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/route/app_page.dart';
import 'core/route/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/firebase/firebase_options.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final categoryService=CategoryService();
  final productService=ProductService();
  final cartService=CartService();
  runApp(
MultiBlocProvider(
    providers: [
  BlocProvider(create: (_)=>ThemeBloc()..add(LoadTheme())),
  BlocProvider(create: (_)=>LoginBloc(loginService: LoginService())),
  BlocProvider(create: (_)=>RegisterBloc(registerService: RegisterService())),
  BlocProvider(create: (_)=>CategoryBloc(categoryService: categoryService)..add(FatchCategoryEvent())),
  BlocProvider(create: (_)=>ProductBloc(productService: productService)),
  BlocProvider(create: (_)=>CartBloc(cartService: cartService)..add(LoadCartEvent()))

 ], child: MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
   return BlocBuilder<ThemeBloc,ThemeState>(builder: (context,state){
     return MaterialApp(
       debugShowCheckedModeBanner: false,
       title: 'Flutter Demo',
       theme: AppTheme.lightTheme,
       themeMode: state.themeMode,
       darkTheme: AppTheme.darkTheme,
       initialRoute: AppRoutes.splash,
       onGenerateRoute: AppPage().generateRoute,
     );
   });
  }
}


