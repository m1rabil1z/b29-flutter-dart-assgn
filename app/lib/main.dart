import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_color_extractor/image_color_extractor.dart';
import 'bloc/palette/palette_bloc.dart';
import 'bloc/palette/palette_event.dart';
import 'bloc/palette/palette_state.dart';
import 'data/image_picker_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaletteBloc(engine: ExtractorEngine()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF121212),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF1E1E1E),
            elevation: 0,
          ),
        ),
        home: const ImagePickerScreen(),
      ),
    );
  }
}

class ImagePickerScreen extends StatelessWidget {
  const ImagePickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ImagePickerService pickerService = ImagePickerService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Color Extractor'),
      ),
      body: BlocListener<PaletteBloc, PaletteState>(
        listener: (context, state) {
          if (state is PaletteSuccess) {
            final colorsList = state.result.colors.map((e) => e.color).toList();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ColorDisplayScreen(extractedColors: colorsList),
              ),
            );
          } else if (state is PaletteFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.redAccent,
                content: Text(
                  'Extraction failed: ${state.error}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          }
        },
        child: BlocBuilder<PaletteBloc, PaletteState>(
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state is PaletteLoading)
                    const CircularProgressIndicator(color: Colors.white)
                  else ...[
                    const Icon(Icons.image, size: 100, color: Colors.grey),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white12,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      icon: const Icon(Icons.add_photo_alternate),
                      label: const Text('Select Image to Extract Colors'),
                      onPressed: () async {
                        final imageBytes = await pickerService.pickImageBytes();
                        if (imageBytes != null && context.mounted) {
                          context.read<PaletteBloc>().add(ExtractPaletteFromImage(imageBytes));
                        }
                      },
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ColorDisplayScreen extends StatelessWidget {
  final List<Color> extractedColors;

  const ColorDisplayScreen({
    super.key,
    required this.extractedColors,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Extracted Colors', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1E1E1E),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Detected Palette',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.5,
                ),
                itemCount: extractedColors.length,
                itemBuilder: (context, index) {
                  final color = extractedColors[index];
                  final hexString = '#${color.toARGB32().toRadixString(16).substring(2).toUpperCase()}';
                  
                  return Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        hexString,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}