import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Screens/on_boarding/on_boarding.dart';
import 'package:shop_app/Shared/services/api/dio_helper.dart';
import 'package:shop_app/Shared/styles/themes.dart';

import 'Shared/services/local/cache_helper.dart';
import 'logic/bloc_observer.dart';
import 'logic/shopping/shopping_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  runApp(MyApp(isDark: isDark));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  const MyApp({super.key, this.isDark});

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
        home: OnBoardingScreen(),
      ),
    );
  }
}
