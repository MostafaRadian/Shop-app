import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Shared/services/api/dio_helper.dart';
import 'package:shop_app/logic/models/search_model/search_model.dart';

import '../../../Shared/constants/constants.dart';
import '../../../Shared/services/endpoints/end_points.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  SearchModel searchModel = SearchModel();
  static SearchCubit get(context) => BlocProvider.of(context);

  Future<void> searchProduct({required String name}) async {
    emit(SearchLoadingState());
    try {
      Response<dynamic> result = await DioHelper.postData(
        url: search,
        auth: token,
        data: {'text': name},
      );
      searchModel = SearchModel.fromJson(result.data);
      emit(SearchSuccessState());
    } on Exception catch (error) {
      if (kDebugMode) {
        print(error);
      }
      emit(SearchErrorState());
    }
  }
}
