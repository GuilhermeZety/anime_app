// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:anime_app/app/core/shared/manga/data/models/manga_slime_model.dart';
import 'package:flutter/foundation.dart';

import 'package:anime_app/app/core/shared/manga/domain/entities/chapter_slime_entity.dart';

class ChapterSlimeModel extends ChapterSlimeEntity {
  const ChapterSlimeModel({
    super.utilsCaps,
    super.bookInfo,
    super.mangaId,
  });

  ChapterSlimeModel copyWith({
    List<UtilsCapsModel>? utilsCaps,
    BookInfoModel? bookInfo,
    String? mangaId,
  }) {
    return ChapterSlimeModel(
      utilsCaps: utilsCaps ?? this.utilsCaps,
      bookInfo: bookInfo ?? this.bookInfo,
      mangaId: mangaId ?? this.mangaId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'utils_caps': utilsCaps?.map((x) => (x as UtilsCapsModel).toMap()).toList(),
      'book_info': (bookInfo as BookInfoModel).toMap(),
      'manga_id': mangaId,
    };
  }

  factory ChapterSlimeModel.fromMap(Map<String, dynamic> map) {
    return ChapterSlimeModel(
      utilsCaps: map['utils_caps'] != null
          ? List<UtilsCapsModel>.from(
              (map['utils_caps'] as List<dynamic>).map<UtilsCapsModel?>(
                (x) => UtilsCapsModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      bookInfo: map['book_info'] != null ? BookInfoModel.fromMap(map['book_info'] as Map<String, dynamic>) : null,
      mangaId: map['book_info'] != null && map['book_info']['book_id'] != null ? map['book_info']['book_id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChapterSlimeModel.fromJson(String source) => ChapterSlimeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ChapterSlimeModel(utilsCaps: $utilsCaps, bookInfo: $bookInfo, mangaId: $mangaId)';

  @override
  bool operator ==(covariant ChapterSlimeModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.utilsCaps, utilsCaps) && other.bookInfo == bookInfo && other.mangaId == mangaId;
  }

  @override
  int get hashCode => utilsCaps.hashCode ^ bookInfo.hashCode ^ mangaId.hashCode;
}

class UtilsCapsModel extends UtilsCapsEntity {
  const UtilsCapsModel({
    super.btcuImage,
  });

  UtilsCapsModel copyWith({
    String? btcuImage,
  }) {
    return UtilsCapsModel(
      btcuImage: btcuImage ?? this.btcuImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'btcu_image': btcuImage,
    };
  }

  factory UtilsCapsModel.fromMap(Map<String, dynamic> map) {
    return UtilsCapsModel(
      btcuImage: map['btcu_image'] != null ? map['btcu_image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UtilsCapsModel.fromJson(String source) => UtilsCapsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UtilsCapsModel(btcuImage: $btcuImage)';

  @override
  bool operator ==(covariant UtilsCapsModel other) {
    if (identical(this, other)) return true;

    return other.btcuImage == btcuImage;
  }

  @override
  int get hashCode => btcuImage.hashCode;
}

class BookInfoModel extends BookInfoEntity {
  const BookInfoModel({
    super.bookNameOriginal,
    super.bookName,
    super.bookId,
    super.bookImage,
    super.bookSinopsis,
    super.bookStatus,
    super.bookTemp,
  });

  BookInfoModel copyWith({
    String? bookNameOriginal,
    String? bookName,
    int? bookId,
    String? bookImage,
    String? bookSinopsis,
    int? bookStatus,
    List<BookTempModel>? bookTemp,
  }) {
    return BookInfoModel(
      bookNameOriginal: bookNameOriginal ?? this.bookNameOriginal,
      bookName: bookName ?? this.bookName,
      bookId: bookId ?? this.bookId,
      bookImage: bookImage ?? this.bookImage,
      bookSinopsis: bookSinopsis ?? this.bookSinopsis,
      bookStatus: bookStatus ?? this.bookStatus,
      bookTemp: bookTemp ?? this.bookTemp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bookNameOriginal': bookNameOriginal,
      'book_name': bookName,
      'book_image': bookImage,
      'book_synopsis': bookSinopsis,
      'book_id': bookId,
      'book_status': bookStatus,
      'book_temp': bookTemp,
    };
  }

  factory BookInfoModel.fromMap(Map<String, dynamic> map) {
    return BookInfoModel(
      bookNameOriginal: map['book_name_original'] != null ? map['book_name_original'] as String : null,
      bookName: map['book_name'] != null ? map['book_name'] as String : null,
      bookId: map['book_id'] is int ? map['book_id'] : int.parse(map['book_id']),
      bookImage: map['book_image'] != null ? (map['book_image'] as String).replaceAll(' ', '%20') : null,
      bookSinopsis: map['book_synopsis'] != null ? map['book_synopsis'] as String : null,
      bookStatus: map['book_status'] != null ? map['book_status'] as int : null,
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

  factory BookInfoModel.fromJson(String source) => BookInfoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BookInfoModel(bookNameOriginal: $bookNameOriginal, bookName: $bookName, bookImage: $bookImage, bookSinopsis: $bookSinopsis, bookStatus: $bookStatus, bookTemp: $bookTemp)';
  }

  @override
  bool operator ==(covariant BookInfoModel other) {
    if (identical(this, other)) return true;

    return other.bookNameOriginal == bookNameOriginal &&
        other.bookName == bookName &&
        other.bookImage == bookImage &&
        other.bookSinopsis == bookSinopsis &&
        other.bookStatus == bookStatus &&
        listEquals(other.bookTemp, bookTemp);
  }

  @override
  int get hashCode {
    return bookNameOriginal.hashCode ^ bookName.hashCode ^ bookImage.hashCode ^ bookSinopsis.hashCode ^ bookStatus.hashCode ^ bookTemp.hashCode;
  }
}
