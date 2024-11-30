import 'package:flutter/material.dart';
import 'package:mywater_web_app/utils/color_scheme.dart';

class ScreenOverlay {
  ScreenOverlay._();

  static showAppSheet(
    BuildContext context, {
    required Widget body,

  }) {
    showModalBottomSheet(
      barrierColor: Colors.black54,
      backgroundColor: MyWaterColor.backgroundColor,
      context: context,
      showDragHandle: true,
      useRootNavigator: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      builder: (context) {
        return body;
      },
    );
  }
}
