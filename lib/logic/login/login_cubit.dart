import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Shared/services/api/dio_helper.dart';
import '../../Shared/services/endpoints/end_points.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    try {
      emit(LoginLoadingState());
      Response<dynamic> result = await DioHelper.postData(
        url: login,
        data: {'email': email, 'password': password},
      );
      if (kDebugMode) {
        print(result.data);
      }
      emit(LoginSuccessState());
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      emit(LoginFailedState());
    }
  }
}
