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

  Future<void> getHomeData() async {
    emit(HomeLoadingState());
    try {
      categories = await HomeApi.getCategories();
      products = await HomeApi.getProducts();
      emit(HomeSuccessState());
    } catch (e) {
      emit(HomeErrorState());
    }
  }
}
