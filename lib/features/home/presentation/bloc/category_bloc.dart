
import 'package:code/features/home/data/service/category_service.dart';
import 'package:code/features/home/presentation/bloc/category_event.dart';
import 'package:code/features/home/presentation/bloc/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent,CategoryState> {
  CategoryService categoryService;
  CategoryBloc({required this.categoryService}):super(CategoryInitial()){
    on<FatchCategoryEvent>(_fatchCategories);
  }
  Future<void> _fatchCategories(FatchCategoryEvent event,Emitter<CategoryState> emit) async{
        emit(CategoryLoading());
    try{
        final  categoryList= await  categoryService.categoriesList();
        print("categoryList:${categoryList.length}");
         emit( CategorySuccess(categoryList));
        }catch(e){
         emit(CategoryError(e.toString()));
        }
  }
}