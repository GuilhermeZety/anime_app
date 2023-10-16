part of 'manga_page_cubit.dart';

sealed class MangaPageState extends Equatable {
  const MangaPageState();

  @override
  List<Object> get props => [];
}

final class MangaPageInitial extends MangaPageState {}

final class MangaPageLoading extends MangaPageState {}

