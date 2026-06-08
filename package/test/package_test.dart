import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_color_extractor/image_color_extractor.dart';

void main() {
  group('ExtractedColor and PaletteResult Tests', () {
    test('ExtractedColor parses hex code to Color object correctly', () {
      final extractedColor = ExtractedColor(
        hexCode: '#FF0000',
        rgbString: 'RGB(255, 0, 0)',
        population: 0.5,
      );

      expect(extractedColor.color.r, 255);
      expect(extractedColor.color.g, 0);
      expect(extractedColor.color.b, 0);
    });

    test('PaletteResult returns the correct dominant color', () {
      final color1 = ExtractedColor(
        hexCode: '#FF0000',
        rgbString: 'RGB(255, 0, 0)',
        population: 0.3,
      );
      final color2 = ExtractedColor(
        hexCode: '#00FF00',
        rgbString: 'RGB(0, 255, 0)',
        population: 0.7,
      );

      final result = PaletteResult(colors: [color1, color2]);

      expect(result.dominantColor, color2);
    });

    test('ExtractorEngine throws an exception on invalid image data', () async {
      final engine = ExtractorEngine();
      expect(
        () async => await engine.extractFromBytes(Uint8List(0)),
        throwsException,
      );
    });
  });
}