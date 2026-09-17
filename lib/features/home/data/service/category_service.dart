import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code/features/home/data/model/category_model.dart';

class CategoryService  {
  FirebaseFirestore firebaseFirestore= FirebaseFirestore.instance;
  Future<List<CategoryModel>>  categoriesList() async{
   final snapshot= await firebaseFirestore.collection('categories').get();
    print('service data_size:${snapshot.docs.length}');
      return snapshot.docs.map((doc){
        print('service data:${doc.data()}');
        return CategoryModel.fromFirestore(doc.id,doc.data());
      }).toList();
  }
}