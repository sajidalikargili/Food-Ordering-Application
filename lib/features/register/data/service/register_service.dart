import 'package:code/core/util/auth_error.dart';
import 'package:code/features/register/data/model/register_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
class RegisterService {
   Future<UserCredential?> register(RegisterModel model) async{
    try{
         UserCredential userCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: model.email.trim(), password: model.password);
         print("register_user_credential:${userCredential.user!.email} + ${userCredential.user!.phoneNumber}");
         final String uid=userCredential.user!.uid;
         print('uid:${uid}');
         print('name:${model.name}');
         print('name:${model.email}');
         await FirebaseFirestore.instance.collection('users').doc(uid).set(
           {
             'name':model.name.trim(),
             'email':model.email.trim(),
             'role':'customer',
             'createdAt':FieldValue.serverTimestamp()

           });
         return userCredential;
    } on FirebaseAuthException catch(e){
      throw AuthError.getAuthErrorMessage(e);
    } catch (e){
       throw  "Something went wrong,Please try again";
    }
}
    Future<UserCredential?> signInWithFacebook() async {
     try {
       final LoginResult result =
       await FacebookAuth.instance.login();

       if (result.status != LoginStatus.success) {
         return null;
       }

       final OAuthCredential credential =
       FacebookAuthProvider.credential(
         result.accessToken!.tokenString,
       );

       final userCredential =
       await FirebaseAuth.instance.signInWithCredential(
         credential,
       );

       final user = userCredential.user!;

       await FirebaseFirestore.instance
           .collection('users')
           .doc(user.uid)
           .set(
         {
           'name': user.displayName ?? '',
           'email': user.email ?? '',
           'phone': user.phoneNumber ?? '',
           'role': 'customer',
           'createdAt': FieldValue.serverTimestamp(),
         },
         SetOptions(merge: true),
       );

       return userCredential;
     } on FirebaseAuthException catch (e) {
       throw e.message ?? 'Facebook sign-in failed';
     } catch (e) {
       throw 'Facebook sign-in failed';
     }
   }
   Future<UserCredential?> signInWithGoogle() async {
     try {
       final GoogleSignInAccount? googleUser =
       await GoogleSignIn().signIn();

       if (googleUser == null) {
         return null;
       }

       final GoogleSignInAuthentication googleAuth =
       await googleUser.authentication;

       final credential = GoogleAuthProvider.credential(
         accessToken: googleAuth.accessToken,
         idToken: googleAuth.idToken,
       );

       final userCredential =
       await FirebaseAuth.instance.signInWithCredential(
         credential,
       );

       final user = userCredential.user!;

       await FirebaseFirestore.instance
           .collection('users')
           .doc(user.uid)
           .set(
         {
           'name': user.displayName ?? '',
           'email': user.email ?? '',
           'phone': user.phoneNumber ?? '',
           'role': 'customer',
           'createdAt': FieldValue.serverTimestamp(),
         },
         SetOptions(merge: true),
       );

       return userCredential;
     } on FirebaseAuthException catch (e) {
       throw e.message ?? 'Google sign-in failed';
     } catch (e) {
       throw 'Google sign-in failed';
     }
   }
   Future<UserCredential?> signInWithApple() async {
     try {
       final appleCredential =
       await SignInWithApple.getAppleIDCredential(
         scopes: [
           AppleIDAuthorizationScopes.email,
           AppleIDAuthorizationScopes.fullName,
         ],
       );

       final oauthCredential =
       OAuthProvider('apple.com').credential(
         idToken: appleCredential.identityToken,
         accessToken: appleCredential.authorizationCode,
       );

       final userCredential =
       await FirebaseAuth.instance.signInWithCredential(
         oauthCredential,
       );

       final user = userCredential.user!;

       await FirebaseFirestore.instance
           .collection('users')
           .doc(user.uid)
           .set(
         {
           'name': user.displayName ?? '',
           'email': user.email ?? '',
           'phone': user.phoneNumber ?? '',
           'role': 'customer',
           'createdAt': FieldValue.serverTimestamp(),
         },
         SetOptions(merge: true),
       );

       return userCredential;
     } on FirebaseAuthException catch (e) {
       throw e.message ?? 'Apple sign-in failed';
     } catch (e) {
       throw 'Apple sign-in failed';
     }
   }

}