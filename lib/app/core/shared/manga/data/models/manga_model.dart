// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:anime_app/app/core/shared/manga/domain/entities/manga_entity.dart';

class MangaModel extends MangaEntity {
  MangaModel({
    super.idSerie,
    super.name,
    super.label,
    super.score,
    super.value,
    super.author,
    super.artist,
    super.categories,
    super.cover,
    super.coverThumb,
    super.coverAvif,
    super.coverThumbAvif,
    super.link,
    super.isComplete,
  });

  MangaModel copyWith({
    int? idSerie,
    String? name,
    String? label,
    String? score,
    String? value,
    String? author,
    String? artist,
    List<CategoryModel>? categories,
    String? cover,
    String? coverThumb,
    String? coverAvif,
    String? coverThumbAvif,
    String? link,
    bool? isComplete,
  }) {
    return MangaModel(
      idSerie: idSerie ?? this.idSerie,
      name: name ?? this.name,
      label: label ?? this.label,
      score: score ?? this.score,
      value: value ?? this.value,
      author: author ?? this.author,
      artist: artist ?? this.artist,
      categories: categories ?? this.categories,
      cover: cover ?? this.cover,
      coverThumb: coverThumb ?? this.coverThumb,
      coverAvif: coverAvif ?? this.coverAvif,
      coverThumbAvif: coverThumbAvif ?? this.coverThumbAvif,
      link: link ?? this.link,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idSerie': idSerie,
      'name': name,
      'label': label,
      'score': score,
      'value': value,
      'author': author,
      'artist': artist,
      'categories': categories?.map((x) => (x as CategoryModel).toMap()).toList(),
      'cover': cover,
      'coverThumb': coverThumb,
      'coverAvif': coverAvif,
      'coverThumbAvif': coverThumbAvif,
      'link': link,
      'isComplete': isComplete,
    };
  }

  factory MangaModel.fromMap(Map<String, dynamic> map) {
    return MangaModel(
      idSerie: map['id_serie'] != null ? map['id_serie'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      label: map['label'] != null ? map['label'] as String : null,
      score: map['score'] != null ? map['score'] as String : null,
      value: map['value'] != null ? map['value'] as String : null,
      author: map['author'] != null ? map['author'] as String : null,
      artist: map['artist'] != null ? map['artist'] as String : null,
      categories: map['categories'] != null
          ? List<CategoryModel>.from(
              (map['categories'] ?? [] as List<CategoryModel>).map<CategoryModel?>(
                (x) => CategoryModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      cover: map['cover'] != null ? map['cover'] as String : null,
      coverThumb: map['cover_thumb'] != null ? map['cover_thumb'] as String : null,
      coverAvif: map['cover_avif'] != null ? map['cover_avif'] as String : null,
      coverThumbAvif: map['cover_thumb_avif'] != null ? map['cover_thumb_avif'] as String : null,
      link: map['link'] != null ? map['link'] as String : null,
      isComplete: map['isComplete'] != null ? map['isComplete'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MangaModel.fromJson(String source) => MangaModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MangaModel(idSerie: $idSerie, name: $name, label: $label, score: $score, value: $value, author: $author, artist: $artist, categories: $categories, cover: $cover, coverThumb: $coverThumb, coverAvif: $coverAvif, coverThumbAvif: $coverThumbAvif, link: $link, isComplete: $isComplete)';
  }

  @override
  bool operator ==(covariant MangaModel other) {
    if (identical(this, other)) return true;

    return other.idSerie == idSerie &&
        other.name == name &&
        other.label == label &&
        other.score == score &&
        other.value == value &&
        other.author == author &&
        other.artist == artist &&
        listEquals(other.categories, categories) &&
        other.cover == cover &&
        other.coverThumb == coverThumb &&
        other.coverAvif == coverAvif &&
        other.coverThumbAvif == coverThumbAvif &&
        other.link == link &&
        other.isComplete == isComplete;
  }

  @override
  int get hashCode {
    return idSerie.hashCode ^
        name.hashCode ^
        label.hashCode ^
        score.hashCode ^
        value.hashCode ^
        author.hashCode ^
        artist.hashCode ^
        categories.hashCode ^
        cover.hashCode ^
        coverThumb.hashCode ^
        coverAvif.hashCode ^
        coverThumbAvif.hashCode ^
        link.hashCode ^
        isComplete.hashCode;
  }
}

class CategoryModel extends CategoryEntity {
  CategoryModel({
    super.idCategory,
    super.idSubDomain,
    super.domain,
    super.name,
  });

  CategoryModel copyWith({
    int? idCategory,
    int? idSubDomain,
    String? domain,
    String? name,
  }) {
    return CategoryModel(
      idCategory: idCategory ?? this.idCategory,
      idSubDomain: idSubDomain ?? this.idSubDomain,
      domain: domain ?? this.domain,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idCategory': idCategory,
      'idSubDomain': idSubDomain,
      'domain': domain,
      'name': name,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      idCategory: map['idCategory'] != null ? map['idCategory'] as int : null,
      idSubDomain: map['idSubDomain'] != null ? map['idSubDomain'] as int : null,
      domain: map['domain'] != null ? map['domain'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) => CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CategoryModel(idCategory: $idCategory, idSubDomain: $idSubDomain, domain: $domain, name: $name)';
  }

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.idCategory == idCategory && other.idSubDomain == idSubDomain && other.domain == domain && other.name == name;
  }

  @override
  int get hashCode {
    return idCategory.hashCode ^ idSubDomain.hashCode ^ domain.hashCode ^ name.hashCode;
  }
}
