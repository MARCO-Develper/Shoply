part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class GetProfileLoading extends ProfileState {}

class GetProfileSuccess extends ProfileState {}

class GetProfileError extends ProfileState {
  final String errorMessage;

  GetProfileError(this.errorMessage);
}

class UpdateProfileLoading extends ProfileState {}

class UpdateProfileSuccess extends ProfileState {}

class UpdateProfileError extends ProfileState {
  final String errorMessage;

  UpdateProfileError(this.errorMessage);
}
