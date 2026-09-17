import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/order_model.dart';
class OrderService {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  OrderService({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  }) : firestore = firestore ?? FirebaseFirestore.instance, auth = auth ?? FirebaseAuth.instance;
  Future<String> createOrder(OrderModel order) async {
    final user = auth.currentUser;
    if (user == null) {
      throw Exception('User is not logged in');
    }
    final docRef = await firestore
        .collection('orders')
        .add(order.toMap());
    return docRef.id;
  }
}