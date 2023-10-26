// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class MangaSlimeEntity extends Equatable {
  final String? bookNameOriginal;
  final String? bookName;
  final String? bookImage;
  final int? bookID;
  final List<BookTempEntity>? bookTemp;

  const MangaSlimeEntity({required this.bookNameOriginal, required this.bookName, required this.bookImage, required this.bookID, required this.bookTemp});

  @override
  List<Object?> get props {
    return [
      bookNameOriginal,
      bookName,
      bookImage,
      bookID,
      bookTemp,
    ];
  }
}

class BookTempEntity extends Equatable {
  final int? btSeason;
  final List<BookTempCapsEntity>? bookTempCaps;

  const BookTempEntity({required this.btSeason, required this.bookTempCaps});

  @override
  List<Object?> get props => [btSeason, bookTempCaps];
}

class BookTempCapsEntity extends Equatable {
  final double? btcCap;
  final String? btcDateUpdated;

  const BookTempCapsEntity({required this.btcCap, required this.btcDateUpdated});

  @override
  List<Object?> get props => [btcCap, btcDateUpdated];
}
