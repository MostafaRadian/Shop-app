import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Shared/components/components.dart';

import '../../logic/Cubits/shopping/shopping_cubit.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShoppingCubit, ShoppingState>(
      listener: (context, state) {
        if (state is ShopChangeFavState) {
          bool isFav = ShoppingCubit.get(context).simpleFavoriteModel.status;
          String message =
              ShoppingCubit.get(context).simpleFavoriteModel.message;
          if (!isFav) {
            showToast(message: message, state: ToastStates.error);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShoppingCubit.get(context).homeModel.status == true &&
              ShoppingCubit.get(context).categoriesModel.status == true,
          builder: (context) => productsBuilder(
              ShoppingCubit.get(context).homeModel,
              ShoppingCubit.get(context).categoriesModel,
              context),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
