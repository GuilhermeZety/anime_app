part of 'manga_search_cubit.dart';

sealed class MangaSearchState extends Equatable {
  const MangaSearchState();

  @override
  List<Object> get props => [];
}

final class MangaSearchInitial extends MangaSearchState {}
