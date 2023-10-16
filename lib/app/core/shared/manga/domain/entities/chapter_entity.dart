// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class ChapterEntity extends Equatable {
  final int? idSerie;
  final int? idChapter;
  final String? name;
  final String? chapterName;
  final String? number;
  final String? date;
  final String? dateCreated;
  final ReleaseEntity? release;
  final String? seasonAnimeFinished;
  final String? officialLink;
  final String? predictionDate;
  final String? predictionDateToCalc;
  final String? serieFirstChapter;
  final String? officialSerieLink;

  const ChapterEntity({
    required this.idSerie,
    required this.idChapter,
    required this.name,
    required this.chapterName,
    required this.number,
    required this.date,
    required this.dateCreated,
    required this.release,
    required this.seasonAnimeFinished,
    required this.officialLink,
    required this.predictionDate,
    required this.predictionDateToCalc,
    required this.serieFirstChapter,
    required this.officialSerieLink,
  });

  @override
  List<Object?> get props {
    return [
      idSerie,
      idChapter,
      name,
      chapterName,
      number,
      date,
      dateCreated,
      release,
      seasonAnimeFinished,
      officialLink,
      predictionDate,
      predictionDateToCalc,
      serieFirstChapter,
      officialSerieLink,
    ];
  }
}

abstract class ScanEntity extends Equatable {
  final int idRelease;
  final int? views;
  final List<ScanlatorEntity>? scanlators;
  final String? link;

  const ScanEntity({required this.idRelease, required this.views, required this.scanlators, required this.link});

  @override
  List<Object?> get props => [idRelease, views, scanlators, link];
}

abstract class ReleaseEntity extends Equatable {
  final int? scanId;
  final int? views;
  final String? link;

  const ReleaseEntity({required this.scanId, required this.views, required this.link});

  @override
  List<Object?> get props => [scanId, views, link];
}

abstract class ScanlatorEntity extends Equatable {
  final int? idScanlator;
  final String? name;
  final String? link;

  const ScanlatorEntity({required this.idScanlator, required this.name, required this.link});

  @override
  List<Object?> get props => [idScanlator, name, link];
}
