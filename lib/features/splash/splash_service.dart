import 'package:code/core/route/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class SplashService {

  static void moveNext(BuildContext context) {
    final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
    Future.delayed(const Duration(seconds: 3), () {
       final current_user=firebaseAuth.currentUser?.uid;
       if(current_user !=null){
         Navigator.pushNamedAndRemoveUntil(context, AppRoutes.main, (route)=>false);
       } else{
         Navigator.pushNamed(context, AppRoutes.login);
       }

    });
  }

}