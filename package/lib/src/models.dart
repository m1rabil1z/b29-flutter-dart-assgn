import 'package:flutter/material.dart';

class ExtractedColor {
  final String hexCode;
  final String rgbString;
  final double population;

  ExtractedColor({
    required this.hexCode,
    required this.rgbString,
    required this.population,
  });

  Color get color {
    final hexString = hexCode.replaceAll('#', '');
    return Color(int.parse('FF$hexString', radix: 16));
  }
}

class PaletteResult {
  final List<ExtractedColor> colors;

  PaletteResult({required this.colors});

  ExtractedColor? get dominantColor {
    if (colors.isEmpty) return null;
    return colors.reduce((a, b) => a.population > b.population ? a : b);
  }
}