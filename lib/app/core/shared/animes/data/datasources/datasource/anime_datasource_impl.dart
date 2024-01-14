import 'package:anime_app/app/core/common/services/requests/request_service.dart';
import 'package:anime_app/app/core/shared/animes/data/datasources/datasource/anime_datasource.dart';
import 'package:anime_app/app/core/shared/animes/data/models/anime_model.dart';
import 'package:anime_app/main.dart';

class AnimetubeDatasourceImpl extends AnimeDatasource {
  final RequestService requestService;

  AnimetubeDatasourceImpl({
    required this.requestService,
  });

  @override
  Future<List<AnimeModel>> getAnimes(String? value, int page) async {
    int itensPerPage = 1000;
    List<Map<String, dynamic>> animes = [];

    if (value == null) {
      animes = await session.supabase.from('animes').select().order('created_at', ascending: false).limit(20).range((page - 1) * 20, (page * 20) - 1);
    } else {
      animes = await session.supabase.from('animes').select().ilike('nome', '%$value%').order('created_at', ascending: false).limit(itensPerPage).range(
            (page - 1) * itensPerPage,
            page * itensPerPage,
          );
    }

    return animes.map((e) => AnimeModel.fromMap(e)).toList();
  }
}
