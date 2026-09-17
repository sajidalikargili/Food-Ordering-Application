import 'package:equatable/equatable.dart';
class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];

}
class getProductByCategoryEvent extends ProductEvent{
  final String categoryId;
  getProductByCategoryEvent({required this.categoryId});
  @override
  // TODO: implement props
  List<Object?> get props => [categoryId];
}
class getPopularProductEvent extends ProductEvent{
 @override
  // TODO: implement props
  List<Object?> get props => [];
}