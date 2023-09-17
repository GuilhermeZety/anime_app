// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:anime_app/app/core/common/enums/video_quality_enum.dart';
import 'package:equatable/equatable.dart';

abstract class EpisodeDataEntity extends Equatable {
  final VideoQualityEnum quality;
  final bool? containsTwo;

  const EpisodeDataEntity({
    required this.quality,
    this.containsTwo,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [quality];
}
