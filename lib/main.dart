import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Screens/Layout/shop_layout.dart';
import 'package:shop_app/Screens/on_boarding/on_boarding.dart';
import 'package:shop_app/Shared/services/api/dio_helper.dart';
import 'package:shop_app/Shared/styles/themes.dart';

import 'Screens/login/login.dart';
import 'Shared/services/local/cache_helper.dart';
import 'logic/Cubits/bloc_observer.dart';
import 'logic/Cubits/shopping/shopping_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  final bool? isDark = CacheHelper.getData(key: 'isDark');
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  String? token = CacheHelper.getData(key: 'token');
  final Widget startWidget = determineStartWidget(onBoarding, token);

  runApp(MyApp(isDark: isDark, startWidget: startWidget));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget startWidget;
  const MyApp({
    super.key,
    this.isDark,
    required this.startWidget,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ShoppingCubit>(
            create: (context) =>
                ShoppingCubit()..changeThemeMode(sharedTheme: isDark))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ShoppingCubit.mode ? ThemeMode.dark : ThemeMode.light,
        home: startWidget,
      ),
    );
  }
}

Widget determineStartWidget(bool? onBoarding, String? token) {
  if (onBoarding != null && onBoarding == true) {
    if (token != null) {
      return const ShopLayout();
    } else {
      return Login();
    }
  } else {
    return const OnBoardingScreen();
  }
}
