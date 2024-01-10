import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Screens/category/category.dart';
import 'package:shop_app/Screens/favourites/favourites.dart';
import 'package:shop_app/Screens/products/products.dart';
import 'package:shop_app/Screens/settings/settings.dart';

import '../../../Shared/services/local/cache_helper.dart';

part 'shopping_state.dart';

class ShoppingCubit extends Cubit<ShoppingState> {
  ShoppingCubit() : super(ShoppingInitial());
  static ShoppingCubit get(context) => BlocProvider.of(context);
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
}
