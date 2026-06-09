import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_color_extractor/image_color_extractor.dart';
import 'palette_event.dart';
import 'palette_state.dart';

class PaletteBloc extends Bloc<PaletteEvent, PaletteState> {
  final ExtractorEngine _engine;

  PaletteBloc({required ExtractorEngine engine})
      : _engine = engine,
        super(PaletteInitial()) {
    on<ExtractPaletteFromImage>(_onExtractPalette);
    on<ClearPalette>(_onClearPalette);
  }

  Future<void> _onExtractPalette(ExtractPaletteFromImage event, Emitter<PaletteState> emit) async {
    emit(PaletteLoading());
    try {
      final List<int> rawHexColors = await _engine.extractFromBytes(event.bytes);
      
      final List<ExtractedColor> extractedColors = [];
      for (int i = 0; i < rawHexColors.length; i++) {
        final int hexVal = rawHexColors[i];
        final int r = (hexVal >> 16) & 0xFF;
        final int g = (hexVal >> 8) & 0xFF;
        final int b = hexVal & 0xFF;
        
        final String hexString = '#${hexVal.toRadixString(16).padLeft(6, '0').toUpperCase()}';
        
        extractedColors.add(
          ExtractedColor(
            hexCode: hexString,
            rgbString: 'rgb($r, $g, $b)',
            population: (rawHexColors.length - i).toDouble(),
          ),
        );
      }

      final result = PaletteResult(colors: extractedColors);
      emit(PaletteSuccess(result));
    } catch (e) {
      emit(PaletteFailure(e.toString()));
    }
  }

  void _onClearPalette(ClearPalette event, Emitter<PaletteState> emit) {
    emit(PaletteInitial());
  }
}