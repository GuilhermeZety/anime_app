import 'package:flutter/services.dart';
import 'package:anime_app/app/core/common/utils/toasting.dart';

class Utils {
  static void copy(context, String text, {bool logged = false}) async {
    await Clipboard.setData(ClipboardData(text: text));
    Toasting.success(context, message: 'Copiado com sucesso!');
  }
}
