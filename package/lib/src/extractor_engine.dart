import 'dart:typed_data';
import 'package:image/image.dart' as img;

class ExtractorEngine {
  Future<List<int>> extractFromBytes(Uint8List bytes, {int maxColors = 4}) async {
    try {
      if (bytes.isEmpty) {
        throw Exception('Invalid image data');
      }

      final image = img.decodeImage(bytes);
      if (image == null) {
        throw Exception('Invalid image data');
      }

      final Map<int, int> colorCounts = {};

      for (var pixel in image) {
        final int r = pixel.r.toInt();
        final int g = pixel.g.toInt();
        final int b = pixel.b.toInt();
        
        final int hexColor = (r << 16) | (g << 8) | b;
        colorCounts[hexColor] = (colorCounts[hexColor] ?? 0) + 1;
      }

      final sortedColors = colorCounts.keys.toList()
        ..sort((a, b) => colorCounts[b]!.compareTo(colorCounts[a]!));

      final List<int> uniquePalette = [];

      for (var rawColor in sortedColors) {
        final int r1 = (rawColor >> 16) & 0xFF;
        final int g1 = (rawColor >> 8) & 0xFF;
        final int b1 = rawColor & 0xFF;

        bool isTooSimilar = false;
        for (var existingColor in uniquePalette) {
          final int r2 = (existingColor >> 16) & 0xFF;
          final int g2 = (existingColor >> 8) & 0xFF;
          final int b2 = existingColor & 0xFF;

          final int rDiff = (r1 - r2).abs();
          final int gDiff = (g1 - g2).abs();
          final int bDiff = (b1 - b2).abs();

          if (rDiff < 45 && gDiff < 45 && bDiff < 45) {
            isTooSimilar = true;
            break;
          }
        }

        if (!isTooSimilar) {
          uniquePalette.add(rawColor);
        }

        if (uniquePalette.length >= maxColors) {
          break;
        }
      }

      return uniquePalette;
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Invalid image data: $e');
    }
  }
}