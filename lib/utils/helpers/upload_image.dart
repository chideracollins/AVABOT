import 'package:image_picker/image_picker.dart';

class UploadImage {
  UploadImage._();

  static final ImagePicker picker = ImagePicker();

  static Future<XFile?> _selectImage(ImageSource source) async {
    final XFile? image = await picker.pickImage(source: source);
    return image;
  }

  static Future<XFile?> fromGallery() async {
    return await _selectImage(ImageSource.gallery);
  }

  static Future<XFile?> fromCamera() async {
    return await _selectImage(ImageSource.camera);
  }
}
