import 'package:anime_app/app/core/common/enums/video_quality_enum.dart';

abstract class Integration {
  final String baseUrl = 'baseUrl';
  String search(String value);
  String episodeData(String uuid);
  String get releases;
  String get calendar;
  String watch(String uuid, VideoQualityEnum quality, bool contains2);
}
