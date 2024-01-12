// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:anime_app/app/core/shared/animes/domain/entities/anime_entity.dart';

class AnimeModel extends AnimeEntity {
  const AnimeModel({
    required super.id,
    super.createdAt,
    super.image,
    super.dubbed,
    super.genders,
    super.name,
    super.episodesCount,
    super.pagesCount,
    super.synopsis,
    super.status,
    super.season,
  });

  AnimeModel copyWith({
    String? id,
    DateTime? createdAt,
    String? image,
    bool? dubbed,
    String? genders,
    String? name,
    int? episodesCount,
    int? pagesCount,
    String? synopsis,
    String? status,
    String? season,
  }) {
    return AnimeModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      image: image ?? this.image,
      dubbed: dubbed ?? this.dubbed,
      genders: genders ?? this.genders,
      name: name ?? this.name,
      episodesCount: episodesCount ?? this.episodesCount,
      pagesCount: pagesCount ?? this.pagesCount,
      synopsis: synopsis ?? this.synopsis,
      status: status ?? this.status,
      season: season ?? this.season,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'imagem': image,
      'dublado': dubbed,
      'generos': genders,
      'nome': name,
      'quantidade_episodios': episodesCount,
      'quantidade_paginas': pagesCount,
      'estacao': season,
      'status': status,
      'sinopse': synopsis,
    };
  }

  factory AnimeModel.fromMap(Map<String, dynamic> map) {
    return AnimeModel(
      id: map['id'] as String,
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      image: map['imagem'] as String?,
      dubbed: map['dublado'] as bool?,
      genders: map['generos'] as String?,
      name: map['nome'] as String?,
      episodesCount: map['quantidade_episodios'] as int?,
      pagesCount: map['quantidade_paginas'] as int?,
      synopsis: map['sinopse'] as String?,
      status: map['status'] as String?,
      season: map['estacao'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnimeModel.fromJson(String source) => AnimeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
