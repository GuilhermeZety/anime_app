import 'package:anime_app/app/core/shared/manga/domain/entities/images_entity.dart';
import 'package:anime_app/app/core/shared/manga/domain/usecases/get_images.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'read_page_state.dart';

class ReadPageCubit extends Cubit<ReadPageState> {
  ReadPageCubit() : super(ReadPageInitial());

  List<ImagesEntity>? listImages;

  void init(int idRelease) async {
    emit(ReadPageLoading());
    listImages = await Modular.get<GetImages>()(GetImagesParams(idRelease: idRelease)).then((value) => value.fold((l) => null, (r) => r));

    emit(ReadPageInitial());
  }

  void setState() {
    emit(ReadPageLoading());
    emit(ReadPageInitial());
  }
}
