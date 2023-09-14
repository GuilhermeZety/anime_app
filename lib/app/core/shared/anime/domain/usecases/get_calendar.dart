import 'package:anime_app/app/core/common/errors/failures.dart';
import 'package:anime_app/app/core/common/features/usecases/usecase.dart';
import 'package:anime_app/app/core/shared/anime/domain/entities/calendar_entity.dart';
import 'package:anime_app/app/core/shared/anime/domain/repositories/anime_repository.dart';
import 'package:dartz/dartz.dart';

class GetCalendar extends Usecase<CalendarEntity, NoParams> {
  final AnimeRepository repository;

  GetCalendar({
    required this.repository,
  });

  @override
  Future<Either<Failure, CalendarEntity>> call(
    NoParams params,
  ) async {
    return await repository.getCalendar();
  }
}
