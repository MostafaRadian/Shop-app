import 'package:dio/dio.dart';
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
import 'package:shop_app/logic/models/Login%20model/login_model.dart';
import 'package:shop_app/logic/models/favourite%20model/favorite_model.dart';
import 'package:shop_app/logic/models/favourite%20model/favourite_model.dart';

import '../../../Shared/constants/constants.dart';
import '../../../Shared/services/endpoints/end_points.dart';
import '../../../Shared/services/local/cache_helper.dart';

part 'shopping_state.dart';

class ShoppingCubit extends Cubit<ShoppingState> {
  ShoppingCubit() : super(ShoppingInitial());
  static ShoppingCubit get(context) => BlocProvider.of(context);
  HomeModel homeModel = HomeModel();
  CategoriesModel categoriesModel = CategoriesModel();
  SimpleFavoriteModel simpleFavoriteModel = SimpleFavoriteModel();
  FavoriteProductsModel favoriteProductsModel = FavoriteProductsModel();
  UserModel userDataModel = UserModel();

  Map<int, bool> favourites = {};
  static bool mode = false;
  static int currentIndex = 0;
  static List<String> titles = ['Salla', 'Category', 'Favourite', 'Profile'];
  static List<Widget> screens = [
    const ProductScreen(),
    const CategoryScreen(),
    const FavouriteScreen(),
    ProfileScreen(),
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

  Future<void> getData() async {
    await getHomeData();
    await getCategoriesData();
    await getFavourite();
    await getProfileData();
  }

  Future<void> getInitial() async {
    await getFavourite();
    await getProfileData();
  }

  Future<void> getProfileData() async {
    emit(ShopGetUserDataLoadingState());
    try {
      Response<dynamic> result =
          await DioHelper.getData(url: profile, auth: token);
      userDataModel = UserModel.fromJson(result.data);
      emit(ShopGetUserDataSuccessState());
    } on Exception catch (error) {
      if (kDebugMode) {
        print(error);
      }
      emit(ShopGetUserDataErrorState());
    }
  }

  Future<void> updateProfileData({
    required String name,
    required String email,
    required String phone,
  }) async {
    emit(ShopUpdateUserLoadingState());
    try {
      Response<dynamic> result = await DioHelper.putData(
        url: update,
        auth: token,
        data: {'name': name, 'email': email, 'phone': phone},
      );
      userDataModel = UserModel.fromJson(result.data);
      emit(ShopUpdateUserSuccessState(userModel: userDataModel));
    } on Exception catch (error) {
      if (kDebugMode) {
        print(error);
      }
      emit(ShopUpdateUserFailedState());
    }
  }

  Future<void> getHomeData() async {
    emit(ShopHomeDataLoadingState());
    try {
      Response<dynamic> result =
          await DioHelper.getData(url: home, auth: token);
      homeModel = HomeModel.fromJson(result.data);
      for (var element in homeModel.data.products) {
        favourites.addAll(
          {element.id: element.inFavourite},
        );
      }

      emit(ShopHomeDataSuccessState());
    } on Exception catch (error) {
      if (kDebugMode) {
        print(error);
      }
      emit(ShopHomeDataErrorState());
    }
  }

  Future<void> getCategoriesData() async {
    emit(ShopHomeDataLoadingState());
    try {
      Response<dynamic> result =
          await DioHelper.getData(url: categories, auth: token);
      categoriesModel = CategoriesModel.fromJson(result.data);

      emit(ShopCategoriesSuccessState());
    } on Exception catch (error) {
      if (kDebugMode) {
        print(error);
      }
      emit(ShopCategoriesErrorState());
    }
  }

  Future<void> getFavourite() async {
    emit(ShopGetFavLoadingState());

    try {
      Response<dynamic> result =
          await DioHelper.getData(url: favourite, auth: token);
      favoriteProductsModel = FavoriteProductsModel.fromJson(result.data);

      emit(ShopGetFavSuccessState());
    } on Exception catch (error) {
      if (kDebugMode) {
        print(error);
      }
      emit(ShopGetFavErrorState());
    }
  }

  Future<void> changeFavourite(productId) async {
    try {
      favourites[productId] = !favourites[productId]!;
      emit(ShopChangeFavState());
      Response<dynamic> result = await DioHelper.postData(
        url: favourite,
        data: {'product_id': productId},
        auth: token,
      );
      simpleFavoriteModel = SimpleFavoriteModel.fromJson(result.data);
      if (!simpleFavoriteModel.status) {
        favourites[productId] = !favourites[productId]!;
      } else {
        getFavourite();
      }

      emit(ShopChangeFavSuccessState());
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      favourites[productId] = !favourites[productId]!;

      emit(ShopChangeFavErrorState());
    }
  }
}
