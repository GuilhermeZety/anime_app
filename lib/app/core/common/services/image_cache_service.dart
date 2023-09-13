import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageCacheService {
  Future<Uint8List?> getImage(String url) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var cached = prefs.getString(url);
      final List<int>? data = (cached != null ? List<int>.from(jsonDecode(cached)) : null);

      if (data != null && data.isNotEmpty) {
        return Uint8List.fromList(data);
      }
      final response = await Dio().get(url, options: Options(responseType: ResponseType.bytes));

      if (response.statusCode! > 199 && response.statusCode! < 300) {
        await prefs.setString(url, jsonEncode(response.data));
        return Uint8List.fromList(response.data);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
