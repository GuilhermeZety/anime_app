import 'package:anime_app/app/core/common/integrations/integration.dart';

class Anitube implements Integration {
  @override
  final String baseUrl = 'https://www.anitube.vip/';

  @override
  String search(String value) => '${baseUrl}busca.php?s=$value&submit=Buscar';

  @override
  String get releases => baseUrl;

  @override
  String get calendar => '${baseUrl}calendario';
}
