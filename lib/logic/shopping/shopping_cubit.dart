import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../Shared/services/local/cache_helper.dart';

part 'shopping_state.dart';

class ShoppingCubit extends Cubit<ShoppingState> {
  ShoppingCubit() : super(ShoppingInitial());
  static ShoppingCubit get(context) => BlocProvider.of(context);
  static bool mode = false;

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
