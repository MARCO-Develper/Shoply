import 'package:hive/hive.dart';
import 'package:shoply/core/model/response/product_response.dart';

class FavoriteLocalData {
  FavoriteLocalData._();
  static FavoriteLocalData? favoriteLocalData;
  static late Box<ProductResponse> favoriteBox;
  
  static Future<FavoriteLocalData> get instance async {
    await Hive.openBox<ProductResponse>('favorite');
    favoriteBox = Hive.box<ProductResponse>('favorite');
    return favoriteLocalData ??= FavoriteLocalData._();
  }

  Future<void> addToFavorite(ProductResponse product) async {
    await favoriteBox.put(product.id, product);
  }

  Future<List<ProductResponse>> getFavorites() async {
    return favoriteBox.values.toList();
  }

  Future<void> removeFromFavorite(int productId) async {
    await favoriteBox.delete(productId);
  }

  Future<void> clearFavorites() async {
    await favoriteBox.clear();
  }

  bool isFavorite(int productId) {
    return favoriteBox.containsKey(productId);
  }
}