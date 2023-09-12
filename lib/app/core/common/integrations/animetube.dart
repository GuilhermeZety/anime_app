class Animetube {
  ///BASE
  final String baseUrl = 'https://www.anitube.vip/';

  //ENDPOINTS
  String search(String value) => '${baseUrl}busca.php?s=$value&submit=Buscar';
}
