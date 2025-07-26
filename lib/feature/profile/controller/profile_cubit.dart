import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shoply/core/data/remote_data/profile_api.dart';
import 'package:shoply/core/model/request/update_user_request.dart';
import 'package:shoply/core/model/response/user_response.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  UserResponse user = UserResponse();
  String? accessToken; 

  Future<void> getDataProfile(String accessToken) async {
    emit(GetProfileLoading());
    try {
      this.accessToken = accessToken;
      user = await ProfileApi.getProfileData(accessToken);
      emit(GetProfileSuccess());
    } catch (e) {
      emit(GetProfileError(e.toString()));
    }
  }

  Future<void> updateProfile(UpdateUserRequest request) async {
    emit(UpdateProfileLoading());
    try {
      if (user.id == null) {
        emit(UpdateProfileError('User ID is missing'));
        return;
      }
      UserResponse updatedUser =
          await ProfileApi.updateProfile(request, user.id.toString());
      user = updatedUser;
      emit(UpdateProfileSuccess());
      emit(GetProfileSuccess());
    } catch (e) {
      emit(UpdateProfileError(e.toString()));
    }
  }
}
