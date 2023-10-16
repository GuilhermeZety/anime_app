part of 'manga_home_cubit.dart';

sealed class MangaHomeState extends Equatable {
  const MangaHomeState();

  @override
  List<Object> get props => [];
}

final class MangaHomeInitial extends MangaHomeState {}

final class MangaHomeSetState extends MangaHomeState {}
