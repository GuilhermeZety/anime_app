// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

abstract class MangaEntity implements Equatable {
  final int? idSerie;
  final String? name;
  final String? label;
  final String? score;
  final String? value;
  final String? author;
  final String? artist;
  final List<CategoryEntity>? categories;
  final String? cover;
  final String? coverThumb;
  final String? coverAvif;
  final String? coverThumbAvif;
  final String? link;
  final bool? isComplete;

  MangaEntity({
    required this.idSerie,
    required this.name,
    required this.label,
    required this.score,
    required this.value,
    required this.author,
    required this.artist,
    required this.categories,
    required this.cover,
    required this.coverThumb,
    required this.coverAvif,
    required this.coverThumbAvif,
    required this.link,
    required this.isComplete,
  });

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        idSerie,
        name,
        label,
        score,
        value,
        author,
        artist,
        categories,
        cover,
        coverThumb,
        coverAvif,
        coverThumbAvif,
        link,
        isComplete,
      ];
}

abstract class CategoryEntity implements Equatable {
  final int? idCategory;
  final int? idSubDomain;
  final String? domain;
  final String? name;

  const CategoryEntity({
    required this.idCategory,
    required this.idSubDomain,
    required this.domain,
    required this.name,
  });

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [idCategory, idSubDomain, domain, name];
}
