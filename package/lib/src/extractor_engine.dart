import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'models.dart';

class ExtractorEngine {
  Future<PaletteResult> extractFromBytes(Uint8List bytes) async {
    final image = img.decodeImage(bytes);
    if (image == null) {
      throw Exception("Could not decode image data.");
    }

    final Map<int, int> colorCounts = {};

    for (int y = 0; y < image.height; y += 4) {
      for (int x = 0; x < image.width; x += 4) {
        final pixel = image.getPixel(x, y);
        
        final int r = pixel.r.toInt();
        final int g = pixel.g.toInt();
        final int b = pixel.b.toInt();
        
        final int hexValue = (0xFF << 24) | (r << 16) | (g << 8) | b;

        colorCounts[hexValue] = (colorCounts[hexValue] ?? 0) + 1;
      }
    }

    final sortedColors = colorCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final totalSampledPixels = colorCounts.values.fold<int>(0, (sum, val) => sum + val);
    final topEntries = sortedColors.take(4).toList();

    final List<ExtractedColor> resultColors = topEntries.map((entry) {
      final int hex = entry.key;
      final int r = (hex >> 16) & 0xFF;
      final int g = (hex >> 8) & 0xFF;
      final int b = hex & 0xFF;
      
      final hexString = '#${r.toRadixString(16).padLeft(2, '0')}${g.toRadixString(16).padLeft(2, '0')}${b.toRadixString(16).padLeft(2, '0')}'.toUpperCase();

      return ExtractedColor(
        hexCode: hexString,
        rgbString: 'RGB($r, $g, $b)',
        population: entry.value / totalSampledPixels,
      );
    }).toList();

    return PaletteResult(colors: resultColors);
  }
}