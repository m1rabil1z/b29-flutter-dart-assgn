# color_extractor_app

A modern, high-performance Flutter application built with a premium dark theme to extract color palettes from any image instantly. 

The application architecture utilizes the BLoC pattern for fast, reactive state management and coordinates with a dedicated image processing service to stream image byte blocks into an isolated extraction engine.

---

## Features

* Premium Dark Interface: Clean dark layout designed to isolate and accentuate extracted palette details without visual distraction.
* State-Driven Engine: Built entirely around flutter_bloc to guarantee lightning-fast state transitions (Initial -> Loading -> Success/Failure).
* Native Gallery Integration: Smooth image picking using an abstract, async service layer built on top of image_picker.
* Precision Extraction: Displays exact Hexadecimal strings mapped onto material color blocks.

---

## Project Directory Structure

````
app/
├── lib/
│   ├── bloc/
│   │   └── palette/
│   │       ├── palette_bloc.dart
│   │       ├── palette_event.dart
│   │       └── palette_state.dart
│   ├── data/
│   │   └── image_picker_service.dart
│   ├── ui/
│   │   ├── screens/
│   │   │   └── home_screen.dart
│   │   └── widgets/
│   │       └── color_swatch_grid.dart
│   └── main.dart
└── test/
    └── widget_test.dart
````

---

## Getting Started

### Prerequisites
Make sure your development machine has the Flutter SDK installed (>=3.0.0).

### Installation

1. Navigate to your app directory:
````
   cd app
````

2. Fetch all required framework packages:
````
   flutter pub get
````

3. Fix the Windows multi-drive Kotlin compilation cache bug (if building on non-C drives) by appending this to your android/gradle.properties:
````
   kotlin.incremental=false
````

4. Launch the application on your connected test device:
````
   flutter run
````


---

## Running Unit Tests

The application features comprehensive state mapping validation using a simulated extraction test suite. To run the tests, execute:
````
flutter test
````