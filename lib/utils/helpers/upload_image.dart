import 'package:image_picker/image_picker.dart';

class UploadImage {
  UploadImage._();

  final ImagePicker picker = ImagePicker();

  Future<XFile?> _selectImage(ImageSource source) async {
    final XFile? image = await picker.pickImage(source: source);
    return image;
  }

  Future<XFile?> fromGallery() async{
    return await _selectImage(ImageSource.gallery);
  }

  Future<XFile?> fromCamera() async{
    return await _selectImage(ImageSource.camera);
  }
}
