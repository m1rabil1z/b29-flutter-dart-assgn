import 'package:image_color_extractor/image_color_extractor.dart';

abstract class PaletteState {}

class PaletteInitial extends PaletteState {}

class PaletteLoading extends PaletteState {}

class PaletteSuccess extends PaletteState {
  final PaletteResult result;
  PaletteSuccess(this.result);
}

class PaletteFailure extends PaletteState {
  final String error;
  PaletteFailure(this.error);
}