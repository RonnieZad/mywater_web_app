import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mywater_web_app/utils/color_scheme.dart';
import 'package:mywater_web_app/utils/extensions.dart';
import 'package:mywater_web_app/utils/typography.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.labelText, required this.action, this.hasPadding = true});

  final String labelText;
  final VoidCallback action;
  final bool? hasPadding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: CupertinoButton(borderRadius: BorderRadius.circular(10.0), color: MyWaterColor.baseColor, onPressed: action, child: label(text: labelText)),
    );
  }
}

class PageCloseButton extends StatelessWidget {
  const PageCloseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 120.0,
      right: 120.0,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          HapticFeedback.selectionClick();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            border: Border.all(color: Colors.white60, width: 0.8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(60), color: Colors.black38),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    paragraph(text: 'Close', color: Colors.white),
                    10.pw,
                    const Icon(
                      CupertinoIcons.multiply,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
