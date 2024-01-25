import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Shared/services/endpoints/end_points.dart';
import 'package:shop_app/logic/models/Login%20model/login_model.dart';

import '../../../Shared/services/api/dio_helper.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static IconData suffix = Icons.visibility_outlined;
  static bool isPassword = true;
  UserModel? user;
  static RegisterCubit get(context) => BlocProvider.of(context);

  Future<void> registerUser({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    emit(RegisterLoadingState());
    Response<dynamic> result = await DioHelper.postData(
      url: register,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone
      },
    );
    user = UserModel.fromJson(result.data);
    emit(RegisterSuccessState());
  }

  void changePassVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePassVisibilityState());
  }
}
