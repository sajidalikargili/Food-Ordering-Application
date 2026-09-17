import 'package:code/features/home/data/model/category_model.dart';
import 'package:equatable/equatable.dart';

class CategoryState extends Equatable {
 const CategoryState();
  @override
  List<Object?> get props => [];
}
class CategoryInitial extends CategoryState{

  @override
  List<Object?> get props => [];
}
class CategoryLoading extends CategoryState{
  @override
  List<Object?> get props => [];
}
class CategorySuccess extends CategoryState{
  final List<CategoryModel> categoryList;
   const  CategorySuccess(this.categoryList);
  @override
  List<Object?> get props => [categoryList];
}
class CategoryError extends CategoryState{
  final String message;
 const  CategoryError(this.message);
  @override
  List<Object?> get props => [message];
}