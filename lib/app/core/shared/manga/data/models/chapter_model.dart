// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:anime_app/app/core/shared/manga/domain/entities/chapter_entity.dart';

class ChapterModel extends ChapterEntity {
  const ChapterModel({
    super.idSerie,
    super.idChapter,
    super.name,
    super.chapterName,
    super.number,
    super.date,
    super.dateCreated,
    super.release,
    super.seasonAnimeFinished,
    super.officialLink,
    super.predictionDate,
    super.predictionDateToCalc,
    super.serieFirstChapter,
    super.officialSerieLink,
  });

  ChapterModel copyWith({
    int? idSerie,
    int? idChapter,
    String? name,
    String? chapterName,
    String? number,
    String? date,
    String? dateCreated,
    ReleaseModel? release,
    String? seasonAnimeFinished,
    String? officialLink,
    String? predictionDate,
    String? predictionDateToCalc,
    String? serieFirstChapter,
    String? officialSerieLink,
  }) {
    return ChapterModel(
      idSerie: idSerie ?? this.idSerie,
      idChapter: idChapter ?? this.idChapter,
      name: name ?? this.name,
      chapterName: chapterName ?? this.chapterName,
      number: number ?? this.number,
      date: date ?? this.date,
      dateCreated: dateCreated ?? this.dateCreated,
      release: release ?? this.release,
      seasonAnimeFinished: seasonAnimeFinished ?? this.seasonAnimeFinished,
      officialLink: officialLink ?? this.officialLink,
      predictionDate: predictionDate ?? this.predictionDate,
      predictionDateToCalc: predictionDateToCalc ?? this.predictionDateToCalc,
      serieFirstChapter: serieFirstChapter ?? this.serieFirstChapter,
      officialSerieLink: officialSerieLink ?? this.officialSerieLink,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idSerie': idSerie,
      'idChapter': idChapter,
      'name': name,
      'chapterName': chapterName,
      'number': number,
      'date': date,
      'dateCreated': dateCreated,
      'release': (release as ReleaseModel).toMap(),
      'seasonAnimeFinished': seasonAnimeFinished,
      'officialLink': officialLink,
      'predictionDate': predictionDate,
      'predictionDateToCalc': predictionDateToCalc,
      'serieFirstChapter': serieFirstChapter,
      'officialSerieLink': officialSerieLink,
    };
  }

  factory ChapterModel.fromMap(Map<String, dynamic> map) {
    return ChapterModel(
      idSerie: map['id_serie'] != null ? map['id_serie'] as int : null,
      idChapter: map['id_chapter'] != null ? map['id_chapter'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      chapterName: map['chapter_name'] != null ? map['chapter_name'] as String : null,
      number: map['number'] != null ? map['number'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      dateCreated: map['date_created'] != null ? map['date_created'] as String : null,
      release: map['releases'] != null ? ReleaseModel.fromMap(map['releases'] as Map<String, dynamic>) : null,
      seasonAnimeFinished: map['seasonAnimeFinished'] != null ? map['seasonAnimeFinished'] as String : null,
      officialLink: map['officialLink'] != null ? map['officialLink'] as String : null,
      predictionDate: map['predictionDate'] != null ? map['predictionDate'] as String : null,
      predictionDateToCalc: map['predictionDateToCalc'] != null ? map['predictionDateToCalc'] as String : null,
      serieFirstChapter: map['serieFirstChapter'] != null ? map['serieFirstChapter'] as String : null,
      officialSerieLink: map['officialSerieLink'] != null ? map['officialSerieLink'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChapterModel.fromJson(String source) => ChapterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChapterModel(idSerie: $idSerie, idChapter: $idChapter, name: $name, chapterName: $chapterName, number: $number, date: $date, dateCreated: $dateCreated, release: $release, seasonAnimeFinished: $seasonAnimeFinished, officialLink: $officialLink, predictionDate: $predictionDate, predictionDateToCalc: $predictionDateToCalc, serieFirstChapter: $serieFirstChapter, officialSerieLink: $officialSerieLink)';
  }

  @override
  bool operator ==(covariant ChapterModel other) {
    if (identical(this, other)) return true;

    return other.idSerie == idSerie &&
        other.idChapter == idChapter &&
        other.name == name &&
        other.chapterName == chapterName &&
        other.number == number &&
        other.date == date &&
        other.dateCreated == dateCreated &&
        other.release == release &&
        other.seasonAnimeFinished == seasonAnimeFinished &&
        other.officialLink == officialLink &&
        other.predictionDate == predictionDate &&
        other.predictionDateToCalc == predictionDateToCalc &&
        other.serieFirstChapter == serieFirstChapter &&
        other.officialSerieLink == officialSerieLink;
  }

  @override
  int get hashCode {
    return idSerie.hashCode ^
        idChapter.hashCode ^
        name.hashCode ^
        chapterName.hashCode ^
        number.hashCode ^
        date.hashCode ^
        dateCreated.hashCode ^
        release.hashCode ^
        seasonAnimeFinished.hashCode ^
        officialLink.hashCode ^
        predictionDate.hashCode ^
        predictionDateToCalc.hashCode ^
        serieFirstChapter.hashCode ^
        officialSerieLink.hashCode;
  }
}

class ReleaseModel extends ReleaseEntity {
  const ReleaseModel({
    super.scanId,
    super.views,
    super.link,
  });

  ReleaseModel copyWith({
    int? scanId,
    List<ScanlatorModel>? scanlators,
    int? views,
    String? link,
  }) {
    return ReleaseModel(
      scanId: scanId ?? this.scanId,
      views: views ?? this.views,
      link: link ?? this.link,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'scanId': scanId,
      'views': views,
      'link': link,
    };
  }

  factory ReleaseModel.fromMap(Map<String, dynamic> map) {
    String? scanIde;

    // Encontre a chave dinamicamente
    map.forEach((key, value) {
      if (key.startsWith('_scan')) {
        scanIde = key;
      }
    });

    return ReleaseModel(
      scanId: map[scanIde]['id_release'] != null ? map[scanIde]['id_release'] as int : null,
      views: map['$scanIde']['views'] != null ? map['$scanIde']['views'] as int : null,
      link: map['$scanIde']['link'] != null ? map['$scanIde']['link'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReleaseModel.fromJson(String source) => ReleaseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReleaseModel(scanId: $scanId, views: $views, link: $link)';
  }

  @override
  bool operator ==(covariant ReleaseModel other) {
    if (identical(this, other)) return true;

    return other.scanId == scanId && other.views == views && other.link == link;
  }

  @override
  int get hashCode {
    return scanId.hashCode ^ views.hashCode ^ link.hashCode;
  }
}

class ScanModel extends ScanEntity {
  const ScanModel({
    required super.idRelease,
    super.views,
    super.scanlators,
    super.link,
  });

  ScanModel copyWith({
    int? idRelease,
    int? views,
    List<ScanlatorModel>? scanlators,
    String? link,
  }) {
    return ScanModel(
      idRelease: idRelease ?? this.idRelease,
      views: views ?? this.views,
      scanlators: scanlators ?? this.scanlators,
      link: link ?? this.link,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idRelease': idRelease,
      'views': views,
      'scanlators': scanlators?.map((x) => (x as ScanlatorModel).toMap()).toList(),
      'link': link,
    };
  }

  factory ScanModel.fromMap(Map<String, dynamic> map) {
    return ScanModel(
      idRelease: map['id_release'] as int,
      views: map['views'] != null ? map['views'] as int : null,
      scanlators: map['scanlators'] != null
          ? List<ScanlatorModel>.from(
              (map['scanlators'] as List<int>).map<ScanlatorModel?>(
                (x) => ScanlatorModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      link: map['link'] != null ? map['link'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ScanModel.fromJson(String source) => ScanModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ScanModel(idRelease: $idRelease, views: $views, scanlators: $scanlators, link: $link)';
  }

  @override
  bool operator ==(covariant ScanModel other) {
    if (identical(this, other)) return true;

    return other.idRelease == idRelease && other.views == views && listEquals(other.scanlators, scanlators) && other.link == link;
  }

  @override
  int get hashCode {
    return idRelease.hashCode ^ views.hashCode ^ scanlators.hashCode ^ link.hashCode;
  }
}

class ScanlatorModel extends ScanlatorEntity {
  const ScanlatorModel({
    super.idScanlator,
    super.name,
    super.link,
  });

  ScanlatorModel copyWith({
    int? idScanlator,
    String? name,
    String? link,
  }) {
    return ScanlatorModel(
      idScanlator: idScanlator ?? this.idScanlator,
      name: name ?? this.name,
      link: link ?? this.link,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id_scanlator': idScanlator,
      'name': name,
      'link': link,
    };
  }

  factory ScanlatorModel.fromMap(Map<String, dynamic> map) {
    return ScanlatorModel(
      idScanlator: map['id_scanlator'] != null ? map['id_scanlator'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      link: map['link'] != null ? map['link'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ScanlatorModel.fromJson(String source) => ScanlatorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ScanlatorModel(idScanlator: $idScanlator, name: $name, link: $link)';

  @override
  bool operator ==(covariant ScanlatorModel other) {
    if (identical(this, other)) return true;

    return other.idScanlator == idScanlator && other.name == name && other.link == link;
  }

  @override
  int get hashCode => idScanlator.hashCode ^ name.hashCode ^ link.hashCode;
}
