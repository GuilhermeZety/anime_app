// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:anime_app/app/core/shared/manga/data/models/chapter_model.dart';
import 'package:anime_app/app/core/shared/manga/domain/entities/chapter_release_entity.dart';
import 'package:flutter/foundation.dart';

// ignore: must_be_immutable
class ChapterReleaseModel extends ChapterReleaseEntity {
  ChapterReleaseModel({
    super.date,
    super.dateString,
    super.dateCreated,
    super.idSerie,
    super.name,
    super.image,
    super.imageThumb,
    super.imageAvif,
    super.imageThumbAvif,
    super.range,
    super.chapters,
    super.link,
  });

  ChapterReleaseModel copyWith({
    String? date,
    String? dateString,
    String? dateCreated,
    int? idSerie,
    String? name,
    String? image,
    String? imageThumb,
    String? imageAvif,
    String? imageThumbAvif,
    String? range,
    List<ChaptersModel>? chapters,
    String? link,
  }) {
    return ChapterReleaseModel(
      date: date ?? this.date,
      dateString: dateString ?? this.dateString,
      dateCreated: dateCreated ?? this.dateCreated,
      idSerie: idSerie ?? this.idSerie,
      name: name ?? this.name,
      image: image ?? this.image,
      imageThumb: imageThumb ?? this.imageThumb,
      imageAvif: imageAvif ?? this.imageAvif,
      imageThumbAvif: imageThumbAvif ?? this.imageThumbAvif,
      range: range ?? this.range,
      chapters: chapters ?? this.chapters,
      link: link ?? this.link,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'dateString': dateString,
      'dateCreated': dateCreated,
      'idSerie': idSerie,
      'name': name,
      'image': image,
      'imageThumb': imageThumb,
      'imageAvif': imageAvif,
      'imageThumbAvif': imageThumbAvif,
      'range': range,
      'chapters': chapters?.map((x) => (x as ChaptersModel).toMap()).toList(),
      'link': link,
    };
  }

  factory ChapterReleaseModel.fromMap(Map<String, dynamic> map) {
    return ChapterReleaseModel(
      date: map['date'] != null ? map['date'] as String : null,
      dateString: map['dateString'] != null ? map['dateString'] as String : null,
      dateCreated: map['date_created'] != null ? map['date_created'] as String : null,
      idSerie: map['id_serie'] != null ? map['id_serie'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      imageThumb: map['image_thumb'] != null ? map['image_thumb'] as String : null,
      imageAvif: map['image_avif'] != null ? map['image_avif'] as String : null,
      imageThumbAvif: map['image_thumb_avif'] != null ? map['image_thumb_avif'] as String : null,
      range: map['range'] != null ? map['range'] as String : null,
      chapters: map['chapters'] != null
          ? List<ChaptersModel>.from(
              (map['chapters'] ?? [] as List<ChapterModel>).map<ChaptersModel?>(
                (x) => ChaptersModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      link: map['link'] != null ? map['link'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChapterReleaseModel.fromJson(String source) => ChapterReleaseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChapterReleaseModel(date: $date, dateString: $dateString, dateCreated: $dateCreated, idSerie: $idSerie, name: $name, image: $image, imageThumb: $imageThumb, imageAvif: $imageAvif, imageThumbAvif: $imageThumbAvif, range: $range, chapters: $chapters, link: $link)';
  }

  @override
  bool operator ==(covariant ChapterReleaseModel other) {
    if (identical(this, other)) return true;

    return other.date == date &&
        other.dateString == dateString &&
        other.dateCreated == dateCreated &&
        other.idSerie == idSerie &&
        other.name == name &&
        other.image == image &&
        other.imageThumb == imageThumb &&
        other.imageAvif == imageAvif &&
        other.imageThumbAvif == imageThumbAvif &&
        other.range == range &&
        listEquals(other.chapters, chapters) &&
        other.link == link;
  }

  @override
  int get hashCode {
    return date.hashCode ^
        dateString.hashCode ^
        dateCreated.hashCode ^
        idSerie.hashCode ^
        name.hashCode ^
        image.hashCode ^
        imageThumb.hashCode ^
        imageAvif.hashCode ^
        imageThumbAvif.hashCode ^
        range.hashCode ^
        chapters.hashCode ^
        link.hashCode;
  }
}

class ChaptersModel extends ChaptersEntity {
  const ChaptersModel({
    super.url,
    super.number,
    super.dateCreated,
    super.scanlator,
  });

  ChaptersModel copyWith({
    String? url,
    String? number,
    String? dateCreated,
    ScanlatorModel? scanlator,
  }) {
    return ChaptersModel(
      url: url ?? this.url,
      number: number ?? this.number,
      dateCreated: dateCreated ?? this.dateCreated,
      scanlator: scanlator ?? this.scanlator,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
      'number': number,
      'dateCreated': dateCreated,
      'scanlator': (scanlator as ScanlatorModel).toMap(),
    };
  }

  factory ChaptersModel.fromMap(Map<String, dynamic> map) {
    String? scanId;

    map.forEach((key, value) {
      if (key.startsWith('scan') && key != 'scanlators') {
        scanId = key;
      }
    });

    return ChaptersModel(
      url: map['url'] != null ? map['url'] as String : null,
      number: map['number'] != null ? map['number'] as String : null,
      dateCreated: map['date_created'] != null ? map['date_created'] as String : null,
      scanlator: map['scanlators'][scanId] != null ? ScanlatorModel.fromMap(map['scanlators'][scanId] as Map<String, dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChaptersModel.fromJson(String source) => ChaptersModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChaptersModel(url: $url, number: $number, dateCreated: $dateCreated, scanlator: $scanlator)';
  }

  @override
  bool operator ==(covariant ChaptersModel other) {
    if (identical(this, other)) return true;

    return other.url == url && other.number == number && other.dateCreated == dateCreated && other.scanlator == scanlator;
  }

  @override
  int get hashCode {
    return url.hashCode ^ number.hashCode ^ dateCreated.hashCode ^ scanlator.hashCode;
  }
}
