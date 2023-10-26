import 'package:anime_app/app/core/common/errors/failures.dart';
import 'package:anime_app/app/core/common/features/usecases/usecase.dart';
import 'package:anime_app/app/core/shared/manga/domain/repositories/manga_repository.dart';
import 'package:dartz/dartz.dart';

class GetImages extends Usecase<List<String>, GetImagesParams> {
  final MangaRepository repository;

  GetImages({required this.repository});

  @override
  Future<Either<Failure, List<String>>> call(
    GetImagesParams params,
  ) async {
    return await repository.getImages(params.mangaId, params.cap);
  }
}

class GetImagesParams {
  final int mangaId;
  final String cap;

  GetImagesParams({
    required this.mangaId,
    required this.cap,
  });
}
