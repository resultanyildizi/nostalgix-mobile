import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'bottom_navbar_state.dart';

class BottomNavbarCubit extends Cubit<BottomNavbarState> {
  BottomNavbarCubit() : super(BottomNavbarState.initial());

  void selectTab(int index) {
    emit(state.copyWith(tabOption: some(BottomNavbarTab.values[index])));
  }
}
