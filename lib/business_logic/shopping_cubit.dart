import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'shopping_state.dart';

class ShoppingCubit extends Cubit<ShoppingState> {
  ShoppingCubit() : super(ShoppingInitial());
}
