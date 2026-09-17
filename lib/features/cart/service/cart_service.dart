import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code/features/cart/cart_item.dart';
import 'package:code/features/cart/model/cart_item_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartService {
  Future<void> addToCart(CartItemModel item) async {
    final user=FirebaseAuth.instance.currentUser;
      if(user==null){
        throw Exception('User  is not logge in');
      }
     FirebaseFirestore.instance.collection('users').doc(user.uid)
         .collection('cart').add(item.toMap());
  }
  Future<List<CartItemModel>> getCartItems() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('User is not logged in');
    }

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('cart')
        .get();

    return snapshot.docs.map((doc) {
      return CartItemModel.fromMap(
        doc.id,       // ⭐ Firestore document ID
        doc.data(),
      );
    }).toList();
  }
  Future<void> updateCartItem(
      String cartItemId,
      int quantity,
      ) async {
    print("updateCartItem: $cartItemId, $quantity");

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('User is not logged in');
    }

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('cart')
          .doc(cartItemId)
          .update({
        'quantity': quantity,
      });

      print("Quantity updated successfully");
    } catch (e) {
      print("UPDATE ERROR: $e");
      rethrow;
    }
  }
  Future<void> deleteCartItem(String cartItemId) async {
    print("deleteCartItem: $cartItemId");

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception("User is not logged in");
    }

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('cart')
          .doc(cartItemId)
          .delete();

      print("Cart item deleted successfully");
    } catch (e) {
      print("DELETE ERROR: $e");
      rethrow;
    }
  }
  Future<void>  cleartCart() async{
    final user=FirebaseAuth.instance.currentUser;
    if(user==null){
      throw Exception("User is not logged in");
    }
    final cartRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('cart');
    final snapshot= await cartRef.get();
    for (final  doc in snapshot.docs){
       await doc.reference.delete();
    }
  }
}