import 'dart:typed_data';

class ImagePickerService {
  Future<Uint8List?> pickImageBytes() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return Uint8List.fromList(List.generate(100, (index) => index % 255));
  }
}