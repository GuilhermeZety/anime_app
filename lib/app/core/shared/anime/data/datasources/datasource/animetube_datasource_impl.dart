import 'package:anime_app/app/core/common/integrations/animetube.dart';
import 'package:anime_app/app/core/common/services/requests/request_service.dart';
import 'package:anime_app/app/core/shared/anime/data/datasources/datasource/anime_datasource.dart';
import 'package:anime_app/app/core/shared/anime/data/models/anime_model.dart';
import 'package:anime_app/app/core/shared/anime/data/models/episode_model.dart';
import 'package:html/parser.dart';

class AnimetubeDatasourceImpl extends AnimeDatasource {
  final RequestService requestService;

  AnimetubeDatasourceImpl({
    required this.requestService,
  });

  Animetube integration = Animetube();

  @override
  Future<List<AnimeModel>> search(String value) async {
    final response = await requestService.get(
      integration.search(value),
    );

    if (response.data != null && response.data is String) {
      List<AnimeModel> animes = [];
      var document = parse(response.data);

      var list = document.querySelectorAll('.ani_loop_item');

      for (var anime in list) {
        var name = anime.querySelector('.ani_loop_item_infos_nome');
        var uuid = name?.attributes['href']?.split('/').last;
        var image = anime.querySelector('.ani_loop_item_img img')?.attributes['src'];

        animes.add(AnimeModel(uuid: uuid ?? 'not_found', image: image, name: name?.text));
      }
      return animes;
    }
    return [];
  }

  @override
  Future<List<EpisodeModel>> getReleases() async {
    await Future.delayed(const Duration(seconds: 2));
    //TODO: IMPLEMENT THIS RELEASES GET

    final response = await requestService.get(
      integration.releases(),
    );

    if (response.data != null && response.data is String) {
      List<EpisodeModel> episodes = [];
      var document = parse(response.data);

      var list = document.querySelectorAll('.mContainer');

      if (list.isEmpty) return [];

      var release = list
          .where(
            (element) => element.querySelector('.mContainer_titulo_content')?.text.contains('Lançamentos') == true,
          )
          .firstOrNull;

      if (release == null) return [];

      var items = release.querySelectorAll('.epi_loop_item');

      for (var ep in items) {
        var image = ep.querySelector('img');

        var imageURL = image?.attributes['src']?.split('/') ?? [];

        var uuid = imageURL[imageURL.length - 2];

        episodes.add(
          EpisodeModel(
            uuid: uuid,
            episode: 0,
            name: image?.attributes['title'],
            image: image?.attributes['src'],
          ),
        );
      }
      return episodes;
    }
    return [];
  }
}
