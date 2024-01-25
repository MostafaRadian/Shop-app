import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/logic/Cubits/shopping/shopping_cubit.dart';

import '../../Shared/components/components.dart';
import '../../Shared/constants/constants.dart';
import '../../Shared/services/local/cache_helper.dart';
import '../../Shared/styles/themes.dart';
import '../../logic/Cubits/register/register_cubit.dart';
import '../Layout/shop_layout.dart';
import '../login/login.dart';

class Register extends StatelessWidget {
  Register({super.key});
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Register',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  defaultFormField(
                    nameController,
                    TextInputType.text,
                    (value) {
                      if (value!.isEmpty) {
                        return "Name must not be empty";
                      }
                      return null;
                    },
                    'Name',
                    defaultColor,
                    const Icon(Icons.person_outline),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    emailController,
                    TextInputType.emailAddress,
                    (value) {
                      if (value!.isEmpty) {
                        return "Email address must not be empty";
                      }
                      return null;
                    },
                    'Email',
                    defaultColor,
                    const Icon(Icons.email_outlined),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    phoneController,
                    TextInputType.phone,
                    (value) {
                      if (value!.isEmpty) {
                        return "Email address must not be empty";
                      }
                      return null;
                    },
                    'Phone',
                    defaultColor,
                    const Icon(Icons.phone_outlined),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<RegisterCubit, RegisterState>(
                    builder: (context, state) {
                      return defaultFormField(
                        passwordController,
                        TextInputType.visiblePassword,
                        (value) {
                          if (value!.isEmpty) {
                            return "Password must not be empty";
                          }
                          return null;
                        },
                        'Password',
                        defaultColor,
                        const Icon(Icons.lock_outline),
                        suffixIcon: RegisterCubit.suffix,
                        hidden: RegisterCubit.isPassword,
                        function: () {
                          RegisterCubit.get(context).changePassVisibility();
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<RegisterCubit, RegisterState>(
                    builder: (context, state) {
                      return ConditionalBuilder(
                        condition: state is! RegisterLoadingState,
                        builder: (BuildContext context) => defaultButton(
                          function: () async {
                            if (formKey.currentState!.validate()) {
                              await RegisterCubit.get(context).registerUser(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          color: defaultColor,
                          text: "Sign up",
                        ),
                        fallback: (BuildContext context) => Center(
                          child: CircularProgressIndicator(
                            color: defaultColor,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                      defaultTextButton(
                        text: 'Login Now',
                        function: () {
                          navigateTo(context, Login());
                        },
                      )
                    ],
                  ),
                  BlocListener<RegisterCubit, RegisterState>(
                    listener: (context, state) {
                      if (state is RegisterSuccessState) {
                        var mod = RegisterCubit.get(context).user;
                        if (mod!.status) {
                          showToast(
                            message: mod.message,
                            state: ToastStates.success,
                          );
                          CacheHelper.saveData(
                            key: 'token',
                            value: mod.data?.token,
                          ).then(
                            (value) {
                              token = CacheHelper.getData(key: 'token');
                              ShoppingCubit.get(context).getInitial().then(
                                    (value) => pushReplace(
                                      context,
                                      const ShopLayout(),
                                    ),
                                  );
                            },
                          );
                        } else {
                          if (mod.message == getWarningMessage()) {
                            showToast(
                              message: mod.message,
                              state: ToastStates.warning,
                            );
                          } else {
                            showToast(
                              message: mod.message,
                              state: ToastStates.error,
                            );
                          }
                        }
                      }
                    },
                    child: Container(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
