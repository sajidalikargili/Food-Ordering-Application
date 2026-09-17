import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code/features/product/data/model/product_model.dart';
class ProductService {
  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
Future<List<ProductModel>> getProductByCategory(String categoryId ) async{
  final snapshot=  await firebaseFirestore.collection('products').where('categoryId',isEqualTo: categoryId).get();
  return snapshot.docs.map((doc){
    return ProductModel.fromFirestore(doc.id,doc.data());
  }).toList();
}
Future<List<ProductModel>> getPopularProducts() async{
  final snapshot= await firebaseFirestore.collection('products').orderBy('rating',descending: true).limit(10).get();
  return snapshot.docs.map((docs){
      return ProductModel.fromFirestore(docs.id, docs.data());
  }).toList();
}
}