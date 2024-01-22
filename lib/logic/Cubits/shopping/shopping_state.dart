part of 'shopping_cubit.dart';

@immutable
abstract class ShoppingState {}

class ShoppingInitial extends ShoppingState {}

class ChangeThemeModeState extends ShoppingState {}

class ChangeBottomNavState extends ShoppingState {}

class ShopHomeDataLoadingState extends ShoppingState {}

class ShopHomeDataSuccessState extends ShoppingState {}

class ShopHomeDataErrorState extends ShoppingState {}

class ShopCategoriesSuccessState extends ShoppingState {}

class ShopCategoriesErrorState extends ShoppingState {}
