import 'package:flutter/material.dart';

extension ImagePath on String {
  String get toSvg => 'assets/images/$this.svg';
  String get toPng => 'assets/images/$this.png';
  String get toGif => 'assets/images/$this.gif';
  String get toJpeg => 'assets/images/$this.jpeg';
  String get toJpg => 'assets/images/$this.jpg';
  String get toMp4 => 'assets/files/$this.mp4';
  String get toJson => 'assets/images/$this.json';
}

extension EmptyPadding on num {
  SizedBox get ph => SizedBox(height: toDouble());
  SizedBox get pw => SizedBox(width: toDouble());
}