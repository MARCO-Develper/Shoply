import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/core/data/local_data/favorite_local_data.dart';
import 'package:shoply/core/model/response/product_response.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  static FavoriteCubit get(context) => BlocProvider.of(context);

  List<ProductResponse> favoriteProducts = [];

  Future<void> getFavoriteProducts() async {
    emit(FavoriteLoading());
    try {
      final favoriteLocalData = await FavoriteLocalData.instance;
      favoriteProducts = await favoriteLocalData.getFavorites();
      emit(FavoriteSuccess());
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  Future<void> toggleFavorite(ProductResponse product) async {
    try {
      final favoriteLocalData = await FavoriteLocalData.instance;

      if (isFavorite(product.id!)) {
        await favoriteLocalData.removeFromFavorite(product.id!);
        favoriteProducts.removeWhere((item) => item.id == product.id);
        emit(ProductRemovedFromFavorite(
            "The product has been removed from favorites"));
      } else {
        await favoriteLocalData.addToFavorite(product);
        favoriteProducts.add(product);
        emit(ProductAddedToFavorite("The product has been added to favorites"));
      }

      emit(FavoriteSuccess());
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  Future<void> clearFavorites() async {
    try {
      final favoriteLocalData = await FavoriteLocalData.instance;
      await favoriteLocalData.clearFavorites();
      favoriteProducts.clear();
      emit(FavoriteSuccess());
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  bool isFavorite(int productId) {
    return favoriteProducts.any((product) => product.id == productId);
  }
}
