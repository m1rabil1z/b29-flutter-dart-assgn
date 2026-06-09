# image_color_extractor

A lightweight, highly portable Dart package built to decode binary image byte streams and extract high-density visual color matrices. 

This engine operates entirely detached from the Flutter UI bindings, making it fully usable across any pure Dart runtime, backend CLI application, or Flutter multi-platform module.

---

## Features

* Quantized Palette Extraction: Scans raw pixel coordinates to determine color populations while cleanly filtering noise.
* Zero UI Overhead: Runs on absolute data structures (Uint8List, List<int>) for peak performance and memory safety.
* Custom Extraction Limits: Extracted palette size can be restricted cleanly via optional named constraints (maxColors).

---

## Usage

### 1. Installation
Add the package path to your host application's pubspec.yaml file:
````
dependencies:
  image_color_extractor:
    path: ../package
````

### 2. Implementation Pipeline
````
import 'dart:typed_data';
import 'package:image_color_extractor/image_color_extractor.dart';

void main() async {
  final ExtractorEngine engine = ExtractorEngine();
  final Uint8List targetBytes = Uint8List.fromList([/* image binary data */]);

  try {
    final List<int> colorPalette = await engine.extractFromBytes(
      targetBytes,
      maxColors: 5,
    );

    print('Extracted Color Tokens: $colorPalette');
  } catch (e) {
    print('Failed to analyze byte matrix: $e');
  }
}
````

---

## Core Package Schema
````
package/
├── lib/
│   ├── image_color_extractor.dart   # Main barrel export file
│   └── src/
│       ├── extractor_engine.dart    # Core bitwise quantization engine
│       └── models.dart
├──test/
│  └── models.dart
└── pubspec.yaml
````