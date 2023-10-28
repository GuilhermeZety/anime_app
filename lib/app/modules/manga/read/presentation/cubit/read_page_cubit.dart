import 'package:anime_app/app/core/shared/manga/domain/entities/manga_slime_entity.dart';
import 'package:anime_app/app/core/shared/manga/domain/usecases/get_images.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'read_page_state.dart';

class ReadPageCubit extends Cubit<ReadPageState> {
  ReadPageCubit() : super(ReadPageInitial());

  List<String>? listImages;
  String? mangaIdButton;
  BookTempCapsEntity? capAtual;
  List<BookTempCapsEntity> capsList = [];
  int? index;

  String? message;

  void init(String mangaId, String cap, List<BookTempCapsEntity>? caps) async {
    emit(ReadPageLoading());
    mangaIdButton = mangaId;
    capAtual = caps?.firstWhere((element) => element.btcCap.toString() == cap);
    capsList = caps ?? [];
    index = capsList.indexOf(capAtual!);
    listImages = await Modular.get<GetImages>()(GetImagesParams(mangaId: int.parse(mangaId), cap: cap)).then((value) => value.fold((l) => null, (r) => r));
    emit(ReadPageInitial());
  }

  void nextCap() async {
    emit(ReadPageLoading());
    if (capAtual?.btcCap == capsList.first.btcCap) {
      emit(ReadPageWarning());
      message = 'Este é o último capitulo';
      emit(ReadPageInitial());
      return;
    }
    if (capAtual?.btcCap != capsList.first.btcCap) {
      index = index! - 1;
      capAtual = capsList[index!];
    }

    listImages = [];
    listImages = await Modular.get<GetImages>()(GetImagesParams(mangaId: int.parse(mangaIdButton!), cap: capAtual!.btcCap.toString())).then((value) => value.fold((l) => null, (r) => r));
    emit(ReadPageInitial());
  }

  void prevCap() async {
    emit(ReadPageLoading());
    if (capAtual?.btcCap == capsList.last.btcCap) {
      emit(ReadPageWarning());
      message = 'Este é o primeiro capítulo';
      emit(ReadPageInitial());
      return;
    }
    if (capAtual?.btcCap != capsList.last.btcCap) {
      index = index! + 1;
      capAtual = capsList[index!];
    }
    listImages = [];
    listImages = await Modular.get<GetImages>()(GetImagesParams(mangaId: int.parse(mangaIdButton!), cap: capAtual!.btcCap.toString())).then((value) => value.fold((l) => null, (r) => r));
    emit(ReadPageInitial());
  }

  void setState() {
    emit(ReadPageLoading());
    emit(ReadPageInitial());
  }
}
