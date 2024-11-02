import 'dart:io';

import 'package:image_picker/image_picker.dart';

class UserQuestion {
  final String? question;
  final XFile? attachedImage;

  const UserQuestion({this.question, this.attachedImage});

  File? get attachedImageFile =>
      attachedImage != null ? File(attachedImage!.path) : null;
}
