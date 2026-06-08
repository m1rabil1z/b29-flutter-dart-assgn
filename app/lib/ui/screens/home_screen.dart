import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/palette/palette_bloc.dart';
import '../../../bloc/palette/palette_event.dart';
import '../../../bloc/palette/palette_state.dart';
import '../../../data/image_picker_service.dart';

class HomeScreen extends StatelessWidget {
  final ImagePickerService _pickerService = ImagePickerService();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaletteBloc, PaletteState>(
      builder: (context, state) {
        Color backgroundColor = const Color(0xFF121212);
        
        if (state is PaletteSuccess) {
          final dominant = state.result.dominantColor;
          if (dominant != null) {
            backgroundColor = dominant.color.withAlpha((0.15 * 255).round());
          }
        }

        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            title: const Text('Color Palette Extractor'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              if (state is PaletteSuccess || state is PaletteFailure)
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () => context.read<PaletteBloc>().add(ClearPalette()),
                ),
            ],
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _buildBodyForState(context, state),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBodyForState(BuildContext context, PaletteState state) {
    if (state is PaletteLoading) {
      return const CircularProgressIndicator();
    }

    if (state is PaletteFailure) {
      return Text(
        state.error,
        style: const TextStyle(color: Colors.red),
      );
    }

    if (state is PaletteSuccess) {
      return const SizedBox.shrink();
    }

    return ElevatedButton.icon(
      onPressed: () async {
        final bytes = await _pickerService.pickImageBytes();
        if (bytes != null && context.mounted) {
          context.read<PaletteBloc>().add(ExtractPaletteFromImage(bytes));
        }
      },
      icon: const Icon(Icons.photo_library),
      label: const Text('Select Image'),
    );
  }
}