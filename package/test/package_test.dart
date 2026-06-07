import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_color_extractor/image_color_extractor.dart';

void main() {
  group('ExtractedColor Tests', () {
    test('should return correct uppercase hex string code', () {
      final extracted = ExtractedColor(
        color: const Color(0xFF1A237E),
        population: 0.5,
      );
      expect(extracted.hexCode, '#1A237E');
    });

    test('should return correct rgb formatted string string', () {
      final extracted = ExtractedColor(
        color: const Color(0xFFF57F17),
        population: 0.3,
      );
      expect(extracted.rgbString, 'RGB(245, 127, 23)');
    });
  });

  group('PaletteResult Tests', () {
    test('dominantColor should return color with highest population ratio', () {
      final lowPopulation = ExtractedColor(color: Colors.red, population: 0.2);
      final highPopulation = ExtractedColor(color: Colors.blue, population: 0.8);
      
      final result = PaletteResult(colors: [lowPopulation, highPopulation]);
      
      expect(result.dominantColor, highPopulation);
    });

    test('dominantColor should return null if colors list is empty', () {
      final result = PaletteResult(colors: []);
      expect(result.dominantColor, isNull);
    });
  });
}