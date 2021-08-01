import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

mixin NetworkNotification {
  void showTopSnackBar(
    BuildContext context,
    String message,
    Color color,
  ) =>
      showSimpleNotification(
        Text('Rede'),
        subtitle: Text(message),
        background: color,
      );
}
