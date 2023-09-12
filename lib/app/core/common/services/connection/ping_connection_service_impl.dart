import 'package:dart_ping/dart_ping.dart';
import 'package:anime_app/app/core/common/services/connection/connection_service.dart';

class PingConnectionServiceImpl extends ConnectionService {
  @override
  Future<bool> get isConnected async {
    try {
      Ping ping = Ping('8.8.8.8', count: 1);
      var response = await ping.stream.first;
      return response.error == null;
    } catch (e) {
      return false;
    }
  }
}
