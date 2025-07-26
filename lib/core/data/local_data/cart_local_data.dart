import 'package:hive/hive.dart';
import 'package:shoply/core/model/response/product_response.dart';

class CartLocalData {
  CartLocalData._();
  static CartLocalData? cartLocalData;
  static late Box<ProductResponse> productBox;
  
  static Future<CartLocalData> get instance async {
    await Hive.openBox<ProductResponse>('cart');
    productBox = Hive.box<ProductResponse>('cart');
    return cartLocalData ??= CartLocalData._();
  }

  Future<void> addToCart(ProductResponse product) async {
    await productBox.put(product.id, product);
  }

  Future<List<ProductResponse>> getCart() async {
    return productBox.values.toList();
  }

  Future<void> deleteToCart(int productId) async {
    await productBox.delete(productId);
  }

  Future<void> updateToCart(ProductResponse product) async {
    await productBox.put(product.id, product);
  }

  Future<void> clearCart() async {
    await productBox.clear();
  }

  bool isInCart(int productId) {
    return productBox.containsKey(productId);
  }
}