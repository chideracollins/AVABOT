import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../utils/constants/images.dart';
import '../models/shopping_session.dart';
import '../utils/helpers/upload_image.dart';
import 'dialogs/error_dialog.dart';

class ShopInput extends StatefulWidget {
  const ShopInput({super.key});

  @override
  State<ShopInput> createState() => _ShopInputState();
}

class _ShopInputState extends State<ShopInput> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _enableInputBox = true;
  bool _isLoading = false;
  bool _isUploading = false;
  double? _uploadingPercentage;

  final CloudinaryPublic cloudinary =
      CloudinaryPublic('dity6y4h4', 'avabot_images', cache: false);
  String? _imageUrl;

  Future<String?> uploadImage(XFile image) async {
    try {
      final response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          image.path,
          folder: 'avabot',
        ),
        onProgress: (count, total) {
          setState(() {
            _uploadingPercentage = count / total;
          });
        },
      );
      return response.secureUrl;
    } on CloudinaryException catch (e) {
      if (mounted) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(
                  "An error ${e.message} was encountered while trying to upload the image, try again!");
            });
      }
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingSession>(builder: (context, modelInstance, child) {
      return Stack(
        alignment: Alignment.centerLeft,
        children: [
          TextField(
            controller: _textEditingController,
            autofocus: true,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: "Message Ava...",
              contentPadding: const EdgeInsets.only(left: 80.0),
              enabled: _enableInputBox,
              suffixIcon: GestureDetector(
                onTap: () async {
                  if (_textEditingController.text.length < 2 &&
                      _imageUrl == null) return;
                  setState(() {
                    _enableInputBox = false;
                    _isLoading = true;
                  });
                  await modelInstance.userRequest(
                    question: _textEditingController.text.isEmpty
                        ? null
                        : _textEditingController.text,
                    attachedImage: _imageUrl,
                  );
                  if (context.mounted) {
                    setState(() {
                      _textEditingController.clear();
                      _imageUrl = null;
                      _enableInputBox = true;
                      _isLoading = false;
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.all(Radius.elliptical(4.0, 4.0)),
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.secondary,
                        Theme.of(context).colorScheme.primary,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: _isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : SizedBox(
                          height: 50,
                          child: Image.asset(
                            Images.sendIcon,
                          ),
                        ),
                ),
              ),
            ),
            showCursor: true,
          ),
          Positioned(
            left: 0,
            child: _imageUrl == null && !_isUploading
                ? Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          XFile? image = await UploadImage.fromGallery();
                          if (image == null) return;
                          setState(() {
                            _isUploading = true;
                          });
                          _imageUrl = await uploadImage(image);
                          setState(() {
                            _isUploading = false;
                          });
                        },
                        icon: const Icon(Icons.image_outlined),
                      ),
                      IconButton(
                        onPressed: () async {
                          XFile? image = await UploadImage.fromCamera();
                          if (image == null) return;
                          setState(() {
                            _isUploading = true;
                          });
                          _imageUrl = await uploadImage(image);
                          setState(() {
                            _isUploading = false;
                          });
                        },
                        icon: const Icon(Icons.camera_alt_outlined),
                      ),
                    ],
                  )
                : Container(
                    height: 60,
                    width: 56,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: !_isUploading
                        ? Stack(
                            children: [
                              Image.network(
                                _imageUrl!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _imageUrl = null;
                                    });
                                  },
                                  icon: const Icon(Icons.close),
                                ),
                              ),
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              value: _uploadingPercentage,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                  ),
          )
        ],
      );
    });
  }
}
