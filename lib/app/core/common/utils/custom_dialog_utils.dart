import 'package:anime_app/app/core/common/extensions/context_extension.dart';
import 'package:flutter/material.dart';

Future<T?> showCustomDialog<T>(
  BuildContext context, {
  required Widget child,
}) async {
  return showModalBottomSheet<T>(
    context: context,
    backgroundColor: Colors.transparent,
    constraints: BoxConstraints(
      maxHeight: context.height * 0.95,
      minHeight: context.height * 0.4,
    ),
    isDismissible: true,
    isScrollControlled: true,
    enableDrag: false,
    elevation: 0,
    builder: (context) => child,
  );
}
