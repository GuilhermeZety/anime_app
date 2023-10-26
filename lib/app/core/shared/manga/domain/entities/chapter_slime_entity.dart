// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:anime_app/app/core/shared/manga/domain/entities/manga_slime_entity.dart';
import 'package:equatable/equatable.dart';

class ChapterSlimeEntity extends Equatable {
  final List<UtilsCapsEntity>? utilsCaps;
  final BookInfoEntity? bookInfo;
  final String? mangaId;

  const ChapterSlimeEntity({required this.utilsCaps, required this.bookInfo, required this.mangaId});

  @override
  List<Object?> get props => [utilsCaps, bookInfo, mangaId];
}

class UtilsCapsEntity extends Equatable {
  final String? btcuImage;

  const UtilsCapsEntity({required this.btcuImage});

  @override
  List<Object?> get props => [btcuImage];
}

class BookInfoEntity extends Equatable {
  final String? bookNameOriginal;
  final String? bookName;
  final String? bookImage;
  final String? bookSinopsis;
  final int? bookStatus;
  final List<BookTempEntity>? bookTemp;

  const BookInfoEntity({required this.bookNameOriginal, required this.bookName, required this.bookImage, required this.bookSinopsis, required this.bookStatus, required this.bookTemp});

  @override
  List<Object?> get props {
    return [
      bookNameOriginal,
      bookName,
      bookImage,
      bookSinopsis,
      bookStatus,
      bookTemp,
    ];
  }
}
