import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/constants/images.dart';
import '../models/shopping_session.dart';
import '../utils/helpers/upload_image.dart';

class ShopInput extends StatefulWidget {
  const ShopInput({super.key});

  @override
  State<ShopInput> createState() => _ShopInputState();
}

class _ShopInputState extends State<ShopInput> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _enableInputBox = true;
  bool _isLoading = false;

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
              contentPadding:
                  const EdgeInsets.only(left: 80.0), // Adjust for icons
              enabled: _enableInputBox,
              suffixIcon: GestureDetector(
                onTap: () async {
                  if (_textEditingController.text.length < 2) return;
                  setState(() {
                    _enableInputBox = false;
                    _isLoading = true;
                  });
                  await modelInstance.userRequest(
                      question: _textEditingController.text);
                  if (context.mounted) {
                    setState(() {
                      _textEditingController.clear();
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
            child: Row(
              children: [
                IconButton(
                  onPressed: () async {
                    await UploadImage.fromGallery();
                  },
                  icon: const Icon(Icons.image_outlined),
                ),
                IconButton(
                  onPressed: () async {
                    await UploadImage.fromCamera();
                  },
                  icon: const Icon(Icons.camera_alt_outlined),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
