import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/logic/models/Login%20model/login_model.dart';

import '../../../Shared/services/api/dio_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static IconData suffix = Icons.visibility_outlined;
  static bool isPassword = true;
  LoginModel? loginMod;

  static LoginCubit get(context) => BlocProvider.of(context);

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    try {
      emit(LoginLoadingState());
      Response<dynamic> result = await DioHelper.postData(
        url: 'login',
        data: {'email': email, 'password': password},
      );
      loginMod = LoginModel.fromJason(result.data);
      if (kDebugMode) {
        print(loginMod?.status);
      }
      if (kDebugMode) {
        print(loginMod?.message);
      }

      emit(LoginSuccessState());
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      emit(LoginFailedState());
    }
  }

  void changePassVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeVisibilityState());
  }
}
