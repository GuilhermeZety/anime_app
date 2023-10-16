import 'package:anime_app/app/core/common/errors/failures.dart';
import 'package:anime_app/app/core/common/features/usecases/usecase.dart';
import 'package:anime_app/app/core/shared/manga/domain/repositories/manga_repository.dart';
import 'package:dartz/dartz.dart';

class GetDescription extends Usecase<String, GetDescriptionParams> {
  final MangaRepository repository;

  GetDescription({required this.repository});

  @override
  Future<Either<Failure, String>> call(
    GetDescriptionParams params,
  ) async {
    return await repository.getDescription(params.url);
  }
}

class GetDescriptionParams {
  final String url;

  GetDescriptionParams({
    required this.url,
  });
}
