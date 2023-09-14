import 'dart:async';

import 'package:anime_app/app/core/common/features/usecases/usecase.dart';
import 'package:anime_app/app/core/shared/anime/domain/entities/calendar_entity.dart';
import 'package:anime_app/app/core/shared/anime/domain/usecases/get_calendar.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit() : super(CalendarInitial());

  bool loading = false;

  CalendarEntity? calendar;

  Future init() async {
    if (calendar == null) {
      loading = true;
      setState();
    }
    calendar = await Modular.get<GetCalendar>()(NoParams()).then((value) => value.fold((l) => null, (r) => r));
    setState();
  }

  void setState() {
    if (state is CalendarSetState) {
      emit(CalendarSetState());
    } else {
      emit(CalendarInitial());
      emit(CalendarSetState());
    }
    emit(CalendarInitial());
  }
}
