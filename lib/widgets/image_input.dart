import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});
  final Function(File image) onPickImage;
  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600,);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(pickedImage.path);
      widget.onPickImage(_selectedImage!);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ElevatedButton.icon(
        onPressed: _takePicture,
        label: Text("Take picture"),
        icon: Icon(Icons.camera));
    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          _selectedImage!,
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    }
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withAlpha(120),
        ),
      ),
      alignment: Alignment.center,
      child: content,
    );
  }
}
