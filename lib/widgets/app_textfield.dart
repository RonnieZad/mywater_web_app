import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mywater_web_app/utils/color_scheme.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({super.key, required this.textEditingController, this.textInputType, required this.hintText, required this.iconData});

  final TextEditingController textEditingController;
  final TextInputType? textInputType;
  final String hintText;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shadowColor: Colors.black45,
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: textEditingController,
              keyboardType: textInputType,
              inputFormatters: textInputType == TextInputType.phone ? [FilteringTextInputFormatter.deny(RegExp('^0')), FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(9)] : null,
              style: const TextStyle(fontFamily: 'Cereal', fontSize: 17.0),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  iconData,
                  color: MyWaterColor.baseColor,
                ),
                hintText: hintText,
                hintStyle: const TextStyle(fontFamily: 'Cereal', fontSize: 17.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(
                    width: 0.5,
                    color: MyWaterColor.baseColor.withOpacity(0.3),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(
                    width: 0.5,
                    color: MyWaterColor.baseColor.withOpacity(0.4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
