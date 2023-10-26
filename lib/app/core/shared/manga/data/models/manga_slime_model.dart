// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:anime_app/app/core/shared/manga/domain/entities/manga_slime_entity.dart';

class MangaSlimeModel extends MangaSlimeEntity {
  const MangaSlimeModel({
    super.bookNameOriginal,
    super.bookName,
    super.bookImage,
    super.bookID,
    super.bookTemp,
  });

  MangaSlimeModel copyWith({
    String? bookNameOriginal,
    String? bookName,
    String? bookImage,
    int? bookID,
    List<BookTempModel>? bookTemp,
  }) {
    return MangaSlimeModel(
      bookNameOriginal: bookNameOriginal ?? this.bookNameOriginal,
      bookName: bookName ?? this.bookName,
      bookImage: bookImage ?? this.bookImage,
      bookID: bookID ?? this.bookID,
      bookTemp: bookTemp ?? this.bookTemp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'book_name_original': bookNameOriginal,
      'book_name': bookName,
      'book_image': bookImage,
      'book_id': bookID,
      'book_temp': bookTemp?.map((x) => (x as BookTempModel).toMap()).toList(),
    };
  }

  factory MangaSlimeModel.fromMap(Map<String, dynamic> map) {
    return MangaSlimeModel(
      bookNameOriginal: map['book_name_original'] != null ? map['book_name_original'] as String : null,
      bookName: map['book_name'] != null ? map['book_name'] as String : null,
      bookImage: map['book_image'] != null ? map['book_image'] as String : null,
      bookID: map['book_id'] != null ? map['book_id'] as int : null,
      bookTemp: map['book_temp'] != null
          ? List<BookTempModel>.from(
              (map['book_temp'] as List<dynamic>).map<BookTempModel?>(
                (x) => BookTempModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MangaSlimeModel.fromJson(String source) => MangaSlimeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MangaSlimeModel(bookNameOriginal: $bookNameOriginal, bookName: $bookName, bookImage: $bookImage, bookID: $bookID, bookTemp: $bookTemp)';
  }

  @override
  bool operator ==(covariant MangaSlimeModel other) {
    if (identical(this, other)) return true;

    return other.bookNameOriginal == bookNameOriginal && other.bookName == bookName && other.bookImage == bookImage && other.bookID == bookID && listEquals(other.bookTemp, bookTemp);
  }

  @override
  int get hashCode {
    return bookNameOriginal.hashCode ^ bookName.hashCode ^ bookImage.hashCode ^ bookID.hashCode ^ bookTemp.hashCode;
  }
}

class BookTempModel extends BookTempEntity {
  const BookTempModel({
    super.btSeason,
    super.bookTempCaps,
  });

  BookTempModel copyWith({
    int? btSeason,
    List<BookTempCapsModel>? bookTempCaps,
  }) {
    return BookTempModel(
      btSeason: btSeason ?? this.btSeason,
      bookTempCaps: bookTempCaps ?? this.bookTempCaps,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bt_season': btSeason,
      'book_temp_caps': bookTempCaps?.map((x) => (x as BookTempCapsModel).toMap()).toList(),
    };
  }

  factory BookTempModel.fromMap(Map<String, dynamic> map) {
    return BookTempModel(
      btSeason: map['bt_season'] != null ? map['bt_season'] as int : null,
      bookTempCaps: map['book_temp_caps'] != null
          ? List<BookTempCapsModel>.from(
              (map['book_temp_caps'] as List<dynamic>).map<BookTempCapsModel?>(
                (x) => BookTempCapsModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookTempModel.fromJson(String source) => BookTempModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'BookTempModel(btSeason: $btSeason, bookTempCaps: $bookTempCaps)';

  @override
  bool operator ==(covariant BookTempModel other) {
    if (identical(this, other)) return true;

    return other.btSeason == btSeason && listEquals(other.bookTempCaps, bookTempCaps);
  }

  @override
  int get hashCode => btSeason.hashCode ^ bookTempCaps.hashCode;
}

class BookTempCapsModel extends BookTempCapsEntity {
  const BookTempCapsModel({
    super.btcCap,
    super.btcDateUpdated,
  });

  BookTempCapsModel copyWith({
    double? btcCap,
    String? btcDateUpdated,
  }) {
    return BookTempCapsModel(
      btcCap: btcCap ?? this.btcCap,
      btcDateUpdated: btcDateUpdated ?? this.btcDateUpdated,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'btc_cap': btcCap,
      'btc_date_updated': btcDateUpdated,
    };
  }

  factory BookTempCapsModel.fromMap(Map<String, dynamic> map) {
    return BookTempCapsModel(
      btcCap: map['btc_cap'] != null ? (double.tryParse(map['btc_cap'].toString())) as double : null,
      btcDateUpdated: map['btc_date_updated'] != null ? map['btc_date_updated'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookTempCapsModel.fromJson(String source) => BookTempCapsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'BookTempCapsModel(btcCap: $btcCap)';

  @override
  bool operator ==(covariant BookTempCapsModel other) {
    if (identical(this, other)) return true;

    return other.btcCap == btcCap;
  }

  @override
  int get hashCode => btcCap.hashCode;
}
