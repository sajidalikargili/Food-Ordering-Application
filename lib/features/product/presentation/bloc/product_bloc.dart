import 'package:code/features/product/data/service/product_service.dart';
import 'package:code/features/product/presentation/bloc/product_event.dart';
import 'package:code/features/product/presentation/bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent,ProductState> {
  ProductService productService;
    ProductBloc({required this.productService}):super(ProductInitial()){
      on<getProductByCategoryEvent>(_getProduct);
      on<getPopularProductEvent>(_getPopularProduct);
    }
    Future<void> _getProduct(getProductByCategoryEvent event,Emitter<ProductState> emit) async{
      emit(ProductLoading());
      try {
        final productList= await productService.getProductByCategory(event.categoryId);
        emit(ProductSuccess(productList:productList));
      }catch(e){
         emit(ProductError(message: e.toString()));
      }
    }
    Future<void> _getPopularProduct(getPopularProductEvent event,Emitter<ProductState> emt) async{
        emit(PopularProductLoading());
      try{
        final  popularProductList= await productService.getPopularProducts();
        emit(PopularProductSuccess(popularProductList: popularProductList));
      }catch(e){
        emit(PopularProductError(message: e.toString()));
      }
    }

}