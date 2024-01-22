import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Screens/category/category.dart';
import 'package:shop_app/Screens/favourites/favourites.dart';
import 'package:shop_app/Screens/products/products.dart';
import 'package:shop_app/Screens/settings/settings.dart';
import 'package:shop_app/Shared/services/api/dio_helper.dart';
import 'package:shop_app/logic/models/Home%20model/home_model.dart';

import '../../../Shared/constants/constants.dart';
import '../../../Shared/services/endpoints/end_points.dart';
import '../../../Shared/services/local/cache_helper.dart';

part 'shopping_state.dart';

class ShoppingCubit extends Cubit<ShoppingState> {
  ShoppingCubit() : super(ShoppingInitial());
  static ShoppingCubit get(context) => BlocProvider.of(context);
  HomeModel? homeModel;
  static bool mode = false;
  static int currentIndex = 0;
  static List<String> titles = [
    'Products',
    'Category',
    'Favourite',
    'Settings'
  ];
  static List<Widget> screens = [
    const ProductScreen(),
    const CategoryScreen(),
    const FavouriteScreen(),
    const SettingsScreen(),
  ];

  void changeBottom({required int index}) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  Future<void> changeThemeMode({bool? sharedTheme}) async {
    if (sharedTheme != null) {
      mode = sharedTheme;
    } else {
      mode = !mode;
      await CacheHelper.putData(key: 'isDark', value: mode);
    }
    emit(ChangeThemeModeState());
  }

  void getHomeData() {
    emit(ShopHomeDataLoadingState());
    try {
      DioHelper.getData(url: home, auth: token).then(
        (value) {
          homeModel = HomeModel.fromJson(value.data);
          emit(ShopHomeDataSuccessState());
        },
      );
    } on Exception catch (error) {
      if (kDebugMode) {
        print(error);
      }
      emit(ShopHomeDataErrorState());
    }
  }
}
