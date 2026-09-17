import 'package:code/features/product/data/model/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
class ProductState extends Equatable {
    const ProductState();
  @override
  // TODO: implement props
  List<Object?> get props => throw [];

}
class ProductInitial extends ProductState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class ProductLoading extends ProductState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class ProductSuccess extends ProductState{
 final List<ProductModel> productList;
 ProductSuccess({required this.productList});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class ProductError extends ProductState{
  final String message;
  ProductError({required this.message});
  @override
  List<Object?> get props => [message];
}
class PopularProductLoading extends ProductState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class PopularProductError extends ProductState{
  final String message;
  PopularProductError({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
class PopularProductSuccess extends ProductState{
  final  List<ProductModel> popularProductList;
  PopularProductSuccess({required this.popularProductList});
  @override
  // TODO: implement props
  List<Object?> get props => [popularProductList];
}
