import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shoply/core/data/remote_data/auth_api.dart';
import 'package:shoply/core/model/request/login_request.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      await AuthApi.login(LoginRequest(email: email, password: password));
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
