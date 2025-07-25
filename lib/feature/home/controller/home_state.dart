part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeCategoryLoading extends HomeState {}

class HomeCategorySuccess extends HomeState {}

class HomeCategoryError extends HomeState {}

class HomeProductLoading extends HomeState {}

class HomeProductSuccess extends HomeState {}

class HomeProductError extends HomeState {}

class HomeProductOfCategory extends HomeState {}

class HomeProductOfCategoryLoading extends HomeState {}

class HomeProductOfCategorySuccess extends HomeState {}

class HomeProductOfCategoryError extends HomeState {
  final String messageError;

  HomeProductOfCategoryError(this.messageError);
}
