import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Screens/register/register.dart';
import 'package:shop_app/Shared/components/components.dart';

import '../../logic/Cubits/login/login_cubit.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'LOGIN',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
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
                    Colors.cyan,
                    const Icon(Icons.email_outlined),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<LoginCubit, LoginState>(
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
                        Colors.cyan,
                        const Icon(Icons.lock_outline),
                        suffixIcon: LoginCubit.suffix,
                        hidden: LoginCubit.isPassword,
                        function: () {
                          LoginCubit.get(context).changePassVisibility();
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      return ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        builder: (BuildContext context) => defaultButton(
                          function: () async {
                            if (formKey.currentState!.validate()) {
                              await LoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          color: Colors.cyan,
                          text: "Sign in",
                        ),
                        fallback: (BuildContext context) => const Center(
                          child: CircularProgressIndicator(
                            color: Colors.cyan,
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
                        "Don't have an account?",
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                      defaultTextButton(
                        text: 'Register Now',
                        function: () {
                          navigateTo(context, const Register());
                        },
                      )
                    ],
                  ),
                  BlocListener<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is LoginSuccessState) {
                        var mod = LoginCubit.get(context).loginMod;
                        if (mod!.status) {
                          Fluttertoast.showToast(
                            msg: mod.message,
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.SNACKBAR,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg: mod.message,
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.SNACKBAR,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
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
