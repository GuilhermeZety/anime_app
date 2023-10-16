// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:anime_app/app/core/shared/manga/domain/entities/chapter_entity.dart';

// ignore: must_be_immutable
abstract class ChapterReleaseEntity extends Equatable {
  final String? date;
  final String? dateString;
  final String? dateCreated;
  final int? idSerie;
  final String? name;
  final String? image;
  final String? imageThumb;
  final String? imageAvif;
  final String? imageThumbAvif;
  final String? range;
  List<ChaptersEntity>? chapters;
  final String? link;

  ChapterReleaseEntity({
    required this.date,
    required this.dateString,
    required this.dateCreated,
    required this.idSerie,
    required this.name,
    required this.image,
    required this.imageThumb,
    required this.imageAvif,
    required this.imageThumbAvif,
    required this.range,
    required this.chapters,
    required this.link,
  });

  @override
  List<Object?> get props {
    return [
      date,
      dateString,
      dateCreated,
      idSerie,
      name,
      image,
      imageThumb,
      imageAvif,
      imageThumbAvif,
      range,
      chapters,
      link,
    ];
  }
}

abstract class ChaptersEntity extends Equatable {
  final String? url;
  final String? number;
  final String? dateCreated;
  final ScanlatorEntity? scanlator;

  const ChaptersEntity({required this.url, required this.number, required this.dateCreated, required this.scanlator});

  @override
  List<Object?> get props => [url, number, dateCreated, scanlator];
}
