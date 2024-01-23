import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Screens/category/category.dart';
import 'package:shop_app/Screens/favourites/favourites.dart';
import 'package:shop_app/Screens/products/products.dart';
import 'package:shop_app/Screens/settings/settings.dart';
import 'package:shop_app/Shared/services/api/dio_helper.dart';
import 'package:shop_app/logic/models/Categories%20model/categories_model.dart';
import 'package:shop_app/logic/models/Home%20model/home_model.dart';
import 'package:shop_app/logic/models/favourite%20model/favorite_model.dart';
import 'package:shop_app/logic/models/favourite%20model/favourite_model.dart';

import '../../../Shared/constants/constants.dart';
import '../../../Shared/services/endpoints/end_points.dart';
import '../../../Shared/services/local/cache_helper.dart';

part 'shopping_state.dart';

class ShoppingCubit extends Cubit<ShoppingState> {
  ShoppingCubit() : super(ShoppingInitial());
  static ShoppingCubit get(context) => BlocProvider.of(context);
  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  SimpleFavoriteModel? simpleFavoriteModel;
  FavoriteProductsModel? favoriteProductsModel;

  Map<int, bool> favourites = {};
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

  void getData() {
    getHomeData();
    getCategoriesData();
    getFavourite();
  }

  void getHomeData() {
    emit(ShopHomeDataLoadingState());
    try {
      DioHelper.getData(url: home, auth: token).then(
        (value) {
          homeModel = HomeModel.fromJson(value.data);
          homeModel?.data?.products.forEach((element) {
            favourites.addAll(
              {element.id: element.inFavourite},
            );
          });
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

  void getCategoriesData() {
    emit(ShopHomeDataLoadingState());
    try {
      DioHelper.getData(url: categories, auth: token).then(
        (value) {
          categoriesModel = CategoriesModel.fromJson(value.data);
          emit(ShopCategoriesSuccessState());
        },
      );
    } on Exception catch (error) {
      if (kDebugMode) {
        print(error);
      }
      emit(ShopCategoriesErrorState());
    }
  }

  void getFavourite() {
    try {
      emit(ShopGetFavLoadingState());
      DioHelper.getData(url: favourite, auth: token).then(
        (value) {
          favoriteProductsModel = FavoriteProductsModel.fromJson(value.data);
          emit(ShopGetFavSuccessState());
        },
      );
    } on Exception catch (error) {
      if (kDebugMode) {
        print(error);
      }
      emit(ShopGetFavErrorState());
    }
  }

  void changeFavourite(productId) {
    try {
      favourites[productId] = !favourites[productId]!;
      emit(ShopChangeFavState());

      DioHelper.postData(
        url: favourite,
        data: {'product_id': productId},
        auth: token,
      ).then(
        (value) {
          simpleFavoriteModel = SimpleFavoriteModel.fromJson(value.data);
          if (!simpleFavoriteModel!.status) {
            favourites[productId] = !favourites[productId]!;
          } else {
            getFavourite();
          }
          emit(ShopChangeFavSuccessState());
        },
      );
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      favourites[productId] = !favourites[productId]!;

      emit(ShopChangeFavErrorState());
    }
  }
}
