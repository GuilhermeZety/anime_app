// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class AnimeEntity extends Equatable {
  final String id;
  final DateTime? createdAt;
  final String? image;
  final bool? dubbed;
  final String? genders;
  final String? name;
  final int? episodesCount;
  final int? pagesCount;
  final String? synopsis;
  final String? status;
  final String? season;

  const AnimeEntity({
    required this.id,
    this.createdAt,
    this.image,
    this.dubbed,
    this.genders,
    this.name,
    this.episodesCount,
    this.pagesCount,
    this.synopsis,
    this.status,
    this.season,
  });

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      createdAt,
      image,
      dubbed,
      genders,
      name,
      episodesCount,
      pagesCount,
      synopsis,
      status,
      season,
    ];
  }
}
