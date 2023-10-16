import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'manga_home_state.dart';

class MangaHomeCubit extends Cubit<MangaHomeState> {
  MangaHomeCubit() : super(MangaHomeInitial());


  int lastIndex = 0;
  late TabController controller;

  void onTabControllerChange() {
    if (controller.index != lastIndex) {
      lastIndex = controller.index;
      emit(MangaHomeSetState());
      emit(MangaHomeInitial());
    }
  }
}
