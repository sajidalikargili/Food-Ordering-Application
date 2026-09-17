import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable{
}
class LoadCartEvent extends CartEvent{
  @override
  List<Object?> get props => [];
}
class IncreaseQuantityEvent extends CartEvent{
  final String cartItemId;
  final int  quantity;
  IncreaseQuantityEvent({required this.cartItemId,required this.quantity});
  @override
  List<Object?> get props => [cartItemId,quantity];
}
class DecreaseQuantityEvent extends CartEvent{
  final String cartItemId;
  final int  quantity;
  DecreaseQuantityEvent({required this.cartItemId,required this.quantity});
  @override
  List<Object?> get props => [cartItemId,quantity];
}
class DeleteCartItemEvent extends CartEvent{
  final String cartItemId;
  DeleteCartItemEvent({required this.cartItemId});
  @override
  List<Object?> get props => [cartItemId];
}
class ClearCartEvent  extends CartEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
