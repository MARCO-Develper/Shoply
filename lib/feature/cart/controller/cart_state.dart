part of 'cart_cubit.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {}

class CartError extends CartState {
  final String message;
  CartError(this.message);
}

class ProductAddedToCart extends CartState {
  final String message;
  ProductAddedToCart(this.message);
}