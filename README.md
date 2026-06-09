# color_extractor_workspace

A monorepo workspace containing a high-performance Dart image processing engine and a responsive Flutter companion client application built using the BLoC state-management pattern.

---

## Repository Architecture

```text
.
├── app/       # Frontend Flutter Client Application
└── package/   # Core Dart Image Extraction Library
```

## Subprojects

### 1. image_color_extractor (Package)

A pure Dart package engineered to decode binary image byte streams and extract high-density visual color matrices. It operates entirely detached from the Flutter UI bindings, making it fully usable across any pure Dart runtime or backend application.

**Path:** `./package`

**Registry:** `pub.dev/packages/image_color_extractor`

### 2. color_extractor_app (Application)

A modern Flutter application built with a premium dark theme to isolate and showcase extracted image color palettes instantly.

**Path:** `./app`

---

## Local Development Setup

To configure and run the entire workspace locally, follow these steps in order.

### Prerequisites

Ensure your machine has the Flutter SDK installed and configured:

- Flutter SDK (>= 3.10.0)

### Step 1: Install Package Dependencies

Navigate into the package engine directory and pull down core dependencies:

```bash
cd package
flutter pub get
```

### Step 2: Install Application Dependencies

Navigate into the frontend client app directory and fetch the structural application dependencies:

```bash
cd ../app
flutter pub get
```

### Step 3: Run the Client Application

Ensure a simulator, emulator, or physical device is connected to your workstation, then execute the compilation runner from the app directory:

```bash
flutter run
```

---

## Monorepo Testing Suite

Both modules contain automated unit and widget test files to validate internal logic state flows.

### Running Package Tests

```bash
cd package
flutter test
```

### Running Application Tests

```bash
cd app
flutter test
```
