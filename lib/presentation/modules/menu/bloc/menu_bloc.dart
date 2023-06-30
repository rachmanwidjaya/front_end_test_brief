import 'package:flutter_bloc/flutter_bloc.dart';

class MenuBLoc extends Cubit<int> {
  MenuBLoc() : super(0);
  void setScreen(int index) => emit(index);
}
