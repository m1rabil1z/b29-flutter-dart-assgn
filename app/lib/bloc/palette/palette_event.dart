import 'dart:typed_data';

abstract class PaletteEvent {}

class ExtractPaletteFromImage extends PaletteEvent {
  final Uint8List bytes;
  ExtractPaletteFromImage(this.bytes);
}

class ClearPalette extends PaletteEvent {}