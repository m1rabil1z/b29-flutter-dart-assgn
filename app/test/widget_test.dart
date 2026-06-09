import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_color_extractor/image_color_extractor.dart';
import 'package:color_extractor_app/bloc/palette/palette_bloc.dart';
import 'package:color_extractor_app/bloc/palette/palette_event.dart';
import 'package:color_extractor_app/bloc/palette/palette_state.dart';

class MockExtractorEngine implements ExtractorEngine {
  @override
  Future<List<int>> extractFromBytes(Uint8List bytes, {int? maxColors}) async {
    return [0xFF0000, 0x00FF00, 0x0000FF];
  }
}

void main() {
  late ExtractorEngine engine;
  late PaletteBloc bloc;

  setUp(() {
    engine = MockExtractorEngine();
    bloc = PaletteBloc(engine: engine);
  });

  tearDown(() {
    bloc.close();
  });

  group('PaletteBloc Unit Tests', () {
    test('initial state should be PaletteInitial', () {
      expect(bloc.state, isA<PaletteInitial>());
    });

    test('ExtractPaletteFromImage event should emit loading and success states', () async {
      final List<PaletteState> states = [];
      final subscription = bloc.stream.listen(states.add);

      bloc.add(ExtractPaletteFromImage(Uint8List(0)));

      await Future.delayed(const Duration(milliseconds: 100));

      expect(states[0], isA<PaletteLoading>());
      expect(states[1], isA<PaletteSuccess>());

      final successState = states[1] as PaletteSuccess;
      expect(successState.result.colors, isNotEmpty);

      await subscription.cancel();
    });

    test('ClearPalette event should return bloc to PaletteInitial state', () async {
      final List<PaletteState> states = [];
      final subscription = bloc.stream.listen(states.add);

      bloc.add(ExtractPaletteFromImage(Uint8List(0)));
      await Future.delayed(const Duration(milliseconds: 100));

      bloc.add(ClearPalette());
      await Future.delayed(Duration.zero);

      expect(states.last, isA<PaletteInitial>());

      await subscription.cancel();
    });
  });
}