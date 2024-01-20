import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Screens/search/search.dart';
import 'package:shop_app/logic/Cubits/shopping/shopping_cubit.dart';

import '../../Shared/components/components.dart';
import '../../Shared/constants/constants.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<ShoppingCubit, ShoppingState>(
          builder: (BuildContext context, state) =>
              Text(ShoppingCubit.titles[ShoppingCubit.currentIndex]),
        ),
        actions: [
          IconButton(
              onPressed: () {
                navigateTo(context, const SearchScreen());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: BlocBuilder<ShoppingCubit, ShoppingState>(
        builder: (BuildContext context, state) =>
            ShoppingCubit.screens[ShoppingCubit.currentIndex],
      ),
      bottomNavigationBar: BlocBuilder<ShoppingCubit, ShoppingState>(
        builder: (context, state) {
          return BottomNavigationBar(
            items: bottomNavList,
            currentIndex: ShoppingCubit.currentIndex,
            onTap: (index) {
              ShoppingCubit.get(context).changeBottom(index: index);
            },
          );
        },
      ),
    );
  }
}
