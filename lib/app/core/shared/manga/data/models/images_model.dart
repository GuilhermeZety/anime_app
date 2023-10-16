// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:anime_app/app/core/shared/manga/domain/entities/images_entity.dart';

class ImagesModel extends ImagesEntity {
  const ImagesModel({
    super.legacy,
    super.avif,
  });

  ImagesModel copyWith({
    String? legacy,
    String? avif,
  }) {
    return ImagesModel(
      legacy: legacy ?? this.legacy,
      avif: avif ?? this.avif,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'legacy': legacy,
      'avif': avif,
    };
  }

  factory ImagesModel.fromMap(Map<String, dynamic> map) {
    return ImagesModel(
      legacy: map['legacy'] != null ? map['legacy'] as String : null,
      avif: map['avif'] != null ? map['avif'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImagesModel.fromJson(String source) => ImagesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ImagesModel(legacy: $legacy, avif: $avif)';

  @override
  bool operator ==(covariant ImagesModel other) {
    if (identical(this, other)) return true;

    return other.legacy == legacy && other.avif == avif;
  }

  @override
  int get hashCode => legacy.hashCode ^ avif.hashCode;
}
