part of 'manga_initial_cubit.dart';

sealed class MangaInitialState extends Equatable {
  const MangaInitialState();

  @override
  List<Object> get props => [];
}

final class MangaInitialInitial extends MangaInitialState {}

final class MangaInitialSetState extends MangaInitialState {}
