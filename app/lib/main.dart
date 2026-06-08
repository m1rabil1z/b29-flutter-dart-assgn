import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_color_extractor/image_color_extractor.dart';
import 'bloc/palette/palette_bloc.dart';
import 'ui/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Palette Extractor',
      theme: ThemeData.dark(useMaterial3: true),
      home: BlocProvider(
        create: (context) => PaletteBloc(engine: ExtractorEngine()),
        child: HomeScreen(),
      ),
    );
  }
}