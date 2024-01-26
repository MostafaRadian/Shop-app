import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Shared/components/components.dart';
import 'package:shop_app/logic/Cubits/shopping/shopping_cubit.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShoppingCubit, ShoppingState>(
      listener: (BuildContext context, ShoppingState state) {},
      builder: (BuildContext context, ShoppingState state) {
        var userData = ShoppingCubit.get(context).userDataModel.data;
        nameController.text = userData.name;
        emailController.text = userData.email;
        phoneController.text = userData.phone;

        return ConditionalBuilder(
          condition: state is! ShopGetUserDataLoadingState,
          builder: (context) => buildSettings(
            context,
            userData,
            nameController,
            emailController,
            phoneController,
            formKey,
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
