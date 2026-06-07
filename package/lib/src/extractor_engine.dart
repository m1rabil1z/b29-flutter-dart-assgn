import 'dart:async';
import 'package:flutter/services.dart';
import 'models.dart';

class ExtractorEngine {
  Future<PaletteResult> extractFromBytes(Uint8List imageBytes, {int maxColors = 5}) async {
    await Future.delayed(const Duration(milliseconds: 600));
    
    final List<ExtractedColor> mockColors = [
      ExtractedColor(color: const Color(0xFF1A237E), population: 0.45),
      ExtractedColor(color: const Color(0xFF0D47A1), population: 0.25),
      ExtractedColor(color: const Color(0xFF006064), population: 0.15),
      ExtractedColor(color: const Color(0xFFF57F17), population: 0.10),
      ExtractedColor(color: const Color(0xFFE65100), population: 0.05),
    ];

    return PaletteResult(colors: mockColors.take(maxColors).toList());
  }
}