import 'package:code/features/cart/model/cart_item_model.dart';
import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable{

}
class CartInitial extends CartState {
  @override
  List<Object?> get props => [];
}
class CartLoading extends CartState{
  @override
  List<Object?> get props => [];
}
class CartLoaded extends CartState{
  List<CartItemModel> items;
  CartLoaded(this.items);
  @override
  List<Object?> get props => [ items];
}
class CartError extends CartState{
  final String message;
  CartError(this.message);
  @override
  List<Object?> get props => [message];
}