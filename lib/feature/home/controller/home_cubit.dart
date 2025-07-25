import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/core/data/remote_data/home_api.dart';
import 'package:shoply/core/model/response/category_response.dart';
import 'package:shoply/core/model/response/product_response.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<CategoryResponse> categories = [];
  List<ProductResponse> products = [];
  List<ProductResponse> productsOfCategory = [];

  // تحميل الفئات
  Future<void> getCategories() async {
    emit(HomeCategoryLoading());
    try {
      categories = await HomeApi.getCategories();
      emit(HomeCategorySuccess());
    } catch (e) {
      emit(HomeCategoryError());
    }
  }

  // تحميل المنتجات
  Future<void> getProducts() async {
    emit(HomeProductLoading());
    try {
      products = await HomeApi.getProducts();
      emit(HomeProductSuccess());
    } catch (e) {
      emit(HomeProductError());
    }
  }

  // تحميل منتجات فئة معينة
  Future<void> getProductsOfCategory(String categoryId) async {
    emit(HomeProductOfCategoryLoading());
    try {
      productsOfCategory = await HomeApi.getProductsOfCategory(categoryId);
      emit(HomeProductOfCategorySuccess());
    } catch (e) {
      emit(HomeProductOfCategoryError(e.toString()));
    }
  }
}