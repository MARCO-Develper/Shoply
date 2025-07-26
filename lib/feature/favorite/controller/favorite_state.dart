part of 'favorite_cubit.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteSuccess extends FavoriteState {}

class FavoriteError extends FavoriteState {
  final String message;
  FavoriteError(this.message);
}

class ProductAddedToFavorite extends FavoriteState {
  final String message;
  ProductAddedToFavorite(this.message);
}

class ProductRemovedFromFavorite extends FavoriteState {
  final String message;
  ProductRemovedFromFavorite(this.message);
}