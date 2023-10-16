import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'manga_search_state.dart';

class MangaSearchCubit extends Cubit<MangaSearchState> {
  MangaSearchCubit() : super(MangaSearchInitial());
}
