import 'package:flutter/material.dart';
import 'package:mywater_web_app/main.dart';
import 'package:mywater_web_app/utils/color_scheme.dart';
import 'package:mywater_web_app/utils/extensions.dart';
import 'package:mywater_web_app/utils/typography.dart';

void toast({required String message, bool isFailure = false}) {
  final SnackBar snackBar = SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      margin: const EdgeInsets.all(8),
      behavior: SnackBarBehavior.floating,
      backgroundColor: !isFailure ? MyWaterColor.baseColor : Colors.orange,
      duration: const Duration(seconds: 6),
      content: Row(
        children: [
          Icon(
            !isFailure ? Icons.check : Icons.error_outline,
            color: Colors.white70,
            size: 36,
          ),
          10.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                paragraph(text: message, color: Colors.white),
              ],
            ),
          )
        ],
      ));
  snackbarKey.currentState!.removeCurrentSnackBar();
  snackbarKey.currentState?.showSnackBar(snackBar);
}
