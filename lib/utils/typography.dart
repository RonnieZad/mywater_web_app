import 'package:flutter/material.dart';

Widget title({String text = '', Color? color, TextAlign textAlign = TextAlign.start, fontFamily = 'Cereal'}) => Text(text, style: TextStyle(fontSize: 42, color: color, fontWeight: FontWeight.bold, fontFamily: fontFamily), textAlign: textAlign);

Widget subtitle({String text = '', Color? color, String? fontFamily = 'Cereal', TextAlign textAlign = TextAlign.start}) => Text(text, style: TextStyle(fontSize: 30, color: color, fontWeight: FontWeight.w500, fontFamily: fontFamily), textAlign: textAlign);

Widget subtitleBold({String text = '', TextAlign textAlign = TextAlign.start}) => Text(text, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800, fontFamily: 'Cereal'), textAlign: textAlign);

Widget headingBig({String text = '', Color? color, String? fontFamily = 'Cereal', TextAlign textAlign = TextAlign.start}) => Text(text, style: TextStyle(fontSize: 22, color: color, fontWeight: FontWeight.w500, fontFamily: fontFamily), textAlign: textAlign);

Widget heading({String text = '', Color? color, textAlign = TextAlign.start, String? fontFamily = 'Cereal'}) => Text(text, style: TextStyle(fontSize: 17, color: color, fontWeight: FontWeight.w500, fontFamily: fontFamily), textAlign: textAlign);

Widget subHeading({String text = '', Color? color}) => Text(text, style: TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.w400, fontFamily: 'Cereal'));

Widget paragraph({String text = '', Color? color, TextAlign textAlign = TextAlign.start, TextOverflow? overflow}) => Text(text, style: TextStyle(height: 1.8, fontSize: 16, color: color, fontWeight: FontWeight.w400, fontFamily: 'Cereal'), overflow: overflow, textAlign: textAlign);

Widget paragraphSmall({String text = '', Color? color, TextAlign textAlign = TextAlign.start}) => Text(text, style: TextStyle(fontSize: 14, color: color, fontWeight: FontWeight.w400, fontFamily: 'Cereal'), textAlign: textAlign);

Widget paragraphSmallItalic({String text = '', Color? color, TextAlign textAlign = TextAlign.start}) => Text(text, style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14, color: color, fontWeight: FontWeight.w400, fontFamily: 'Cereal'), textAlign: textAlign);

Widget paragraphBold({String text = '', Color? color, textAlign = TextAlign.start}) => Text(text, style: TextStyle(fontSize: 22, color: color, fontWeight: FontWeight.w600, fontFamily: 'Cereal'), textAlign: textAlign);

Widget label({String text = '', Color? color}) => Text(text, style: TextStyle(fontSize: 17, color: color, fontWeight: FontWeight.w500, fontFamily: 'Cereal'));

Widget buttonLabelSmallBold({String text = '', Color? color}) => Text(text, style: TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.w600, fontFamily: 'Cereal'));

Widget buttonLabelBold({String text = '', Color? color = Colors.white}) => Text(text, style: TextStyle(fontSize: 20, color: color, fontWeight: FontWeight.w600, fontFamily: 'Cereal'));

Widget caption({String text = '', Color? color, TextAlign textAlign = TextAlign.start}) => Text(text, style: TextStyle(fontSize: 17, color: color, fontWeight: FontWeight.w500, fontFamily: 'Cereal'), textAlign: textAlign);

Widget captionBold({String text = '', Color? color, TextAlign textAlign = TextAlign.start}) => Text(text, style: TextStyle(fontSize: 16.5, color: color, fontWeight: FontWeight.w600, fontFamily: 'Cereal'), textAlign: textAlign);
