import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code/features/detail/model/extra_model.dart';

class CartItemModel {
  final String? id; // Firestore cart document ID
  final String productId;
  final String name;
  final String image;
  final double price;
  final int quantity;
  final List<ExtraModel> extras;

  CartItemModel({
     this.id,
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
    required this.extras,
  });

  double get extrasTotal {
    return extras.fold(
      0,
          (sum, extra) => sum + extra.price,
    );
  }

  double get totalPrice {
    return (price + extrasTotal) * quantity;
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
      'extras': extras.map((extra) {
        return {
          'name': extra.name,
          'price': extra.price,
        };
      }).toList(),
      'totalPrice': totalPrice,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  factory CartItemModel.fromMap(
      String id,
      Map<String, dynamic> map,
      ) {
    return CartItemModel(
      id: id,
      productId: map['productId'] ?? '',
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      quantity: map['quantity'] ?? 1,
      extras: (map['extras'] as List<dynamic>? ?? [])
          .map(
            (extra) => ExtraModel(
          name: extra['name'] ?? '',
          price: (extra['price'] as num?)?.toDouble() ?? 0.0,
        ),
      )
          .toList(),
    );
  }
}