import 'package:flutter/material.dart';

class ExtractedColor {
  final Color color;
  final double population;

  ExtractedColor({
    required this.color,
    required this.population,
  });

  String get hexCode {
    final int argb32 = color.toARGB32();
    return '#${argb32.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
  }

  String get rgbString {
    final int r = (color.r * 255.0).round().clamp(0, 255);
    final int g = (color.g * 255.0).round().clamp(0, 255);
    final int b = (color.b * 255.0).round().clamp(0, 255);
    return 'RGB($r, $g, $b)';
  }
}

class PaletteResult {
  final List<ExtractedColor> colors;

  PaletteResult({required this.colors});

  ExtractedColor? get dominantColor {
    if (colors.isEmpty) return null;
    return colors.reduce((current, next) => current.population > next.population ? current : next);
  }
}