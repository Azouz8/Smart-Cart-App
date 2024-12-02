import 'package:flutter/material.dart';

class TextStylesLight {
  static getLabelLarge() => const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black);

  static getBodyLarge() => const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black);

  static getTitleMedium() => const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black);

  static getTitleSmall() => const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black);

  static getHeadlineMedium() => const TextStyle(
      fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black);

  static getHeadlineSmall() => const TextStyle(
      fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black);

  static getDisplaySmall() => const TextStyle(
      fontSize: 12, fontWeight: FontWeight.w900, color: Colors.black);
}
