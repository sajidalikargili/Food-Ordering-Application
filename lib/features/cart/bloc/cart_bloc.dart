import 'package:code/features/cart/bloc/cart_event.dart';
import 'package:code/features/cart/bloc/cart_state.dart';
import 'package:code/features/cart/model/cart_item_model.dart';
import 'package:code/features/cart/service/cart_service.dart';
import 'package:code/features/home/data/service/category_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartService cartService;

  CartBloc({required this.cartService,}) : super(CartInitial()) {
    on<LoadCartEvent>(_loadCart);
    on<IncreaseQuantityEvent>(_increamentQuantity);
    on<DecreaseQuantityEvent>(_decreamentQuantity);
    on<DeleteCartItemEvent>(_deleteCartItem);
    on<ClearCartEvent>(_clearCart);
  }
  Future<void> _loadCart(LoadCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final items = await cartService.getCartItems();
      emit(CartLoaded(items));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
  Future<void> _increamentQuantity(IncreaseQuantityEvent event,Emitter<CartState> emit) async{
    try {
      await cartService.updateCartItem(
        event.cartItemId,
        event.quantity + 1,
      );

      if (state is CartLoaded) {
        final currentItems = List<CartItemModel>.from(
          (state as CartLoaded).items,
        );

        final index = currentItems.indexWhere(
              (item) => item.id == event.cartItemId,
        );

        if (index != -1) {
          final oldItem = currentItems[index];

          currentItems[index] = CartItemModel(
            id: oldItem.id,
            productId: oldItem.productId,
            name: oldItem.name,
            image: oldItem.image,
            price: oldItem.price,
            quantity: oldItem.quantity + 1,
            extras: oldItem.extras,
          );
        }

        emit(CartLoaded(currentItems));
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
  Future<void> _decreamentQuantity(DecreaseQuantityEvent event,Emitter<CartState> emit) async{
    if (event.quantity <= 1) return;

    try {
      await cartService.updateCartItem(
        event.cartItemId,
        event.quantity - 1,
      );

      if (state is CartLoaded) {
        final currentItems = List<CartItemModel>.from(
          (state as CartLoaded).items,
        );

        final index = currentItems.indexWhere(
              (item) => item.id == event.cartItemId,
        );

        if (index != -1) {
          final oldItem = currentItems[index];

          currentItems[index] = CartItemModel(
            id: oldItem.id,
            productId: oldItem.productId,
            name: oldItem.name,
            image: oldItem.image,
            price: oldItem.price,
            quantity: oldItem.quantity - 1,
            extras: oldItem.extras,
          );
        }

        emit(CartLoaded(currentItems));
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
  Future<void>  _deleteCartItem(DeleteCartItemEvent event,Emitter<CartState> emit) async{
    try {
      await cartService.deleteCartItem(
        event.cartItemId,
      );

      if (state is CartLoaded) {
        final currentItems = List<CartItemModel>.from(
          (state as CartLoaded).items,
        );
        currentItems.removeWhere((item) => item.id == event.cartItemId,);
        emit(CartLoaded(currentItems));
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }

  }
  Future<void> _clearCart(ClearCartEvent event, Emitter<CartState> emit) async{
      try{
          await  cartService.cleartCart();
          emit(CartLoaded([]));
      }catch(e){
          emit(CartError(e.toString()));
      }
  }

}