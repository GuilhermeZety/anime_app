import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'initial_state.dart';

class InitialCubit extends Cubit<InitialState> {
  InitialCubit() : super(InitialInitial());

  late TabController controller;

  void init() {}
}
