import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Shared/components/components.dart';
import 'package:shop_app/logic/models/favourite%20model/favorite_model.dart';

import '../../logic/Cubits/shopping/shopping_cubit.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingCubit, ShoppingState>(builder: (context, state) {
      List<FavoritesData>? data =
          ShoppingCubit.get(context).favoriteProductsModel?.data?.data;
      return ConditionalBuilder(
        condition: state is! ShopGetFavLoadingState,
        builder: (context) => favoriteBuilder(data, context),
        fallback: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}
