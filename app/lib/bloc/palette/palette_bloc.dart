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
      final result = await _engine.extractFromBytes(event.bytes);
      emit(PaletteSuccess(result));
    } catch (e) {
      emit(PaletteFailure(e.toString()));
    }
  }

  void _onClearPalette(ClearPalette event, Emitter<PaletteState> emit) {
    emit(PaletteInitial());
  }
}