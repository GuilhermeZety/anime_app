import 'dart:developer';

import 'package:anime_app/app/core/shared/manga/domain/usecases/get_images.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'read_page_state.dart';

class ReadPageCubit extends Cubit<ReadPageState> {
  ReadPageCubit() : super(ReadPageInitial());

  List<String>? listImages;

  void init(String mangaId, String cap) async {
    emit(ReadPageLoading());
    listImages = await Modular.get<GetImages>()(GetImagesParams(mangaId: int.parse(mangaId), cap: cap)).then((value) => value.fold((l) => null, (r) => r));
    log(listImages.toString());

    emit(ReadPageInitial());
  }

  void setState() {
    emit(ReadPageLoading());
    emit(ReadPageInitial());
  }
}
