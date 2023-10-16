import 'package:anime_app/app/core/common/errors/failures.dart';
import 'package:anime_app/app/core/common/features/usecases/usecase.dart';
import 'package:anime_app/app/core/shared/manga/domain/entities/images_entity.dart';
import 'package:anime_app/app/core/shared/manga/domain/repositories/manga_repository.dart';
import 'package:dartz/dartz.dart';

class GetImages extends Usecase<List<ImagesEntity>, GetImagesParams> {
  final MangaRepository repository;

  GetImages({required this.repository});

  @override
  Future<Either<Failure, List<ImagesEntity>>> call(
    GetImagesParams params,
  ) async {
    return await repository.getImages(params.idRelease);
  }
}

class GetImagesParams {
  final int idRelease;

  GetImagesParams({
    required this.idRelease,
  });
}
