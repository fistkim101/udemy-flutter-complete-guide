import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignUpProfileImage extends StatefulWidget {
  Function setImageFile;

  SignUpProfileImage({
    super.key,
    required this.setImageFile,
  });

  @override
  _SignUpProfileImageState createState() => _SignUpProfileImageState();
}

class _SignUpProfileImageState extends State<SignUpProfileImage> {
  ImagePicker imagePicker = ImagePicker();
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
        ),
        TextButton.icon(
          onPressed: _takePicture,
          icon: const Icon(Icons.image),
          label: const Text('Add Image'),
        ),
      ],
    );
  }

  Future<void> _takePicture() async {
    final XFile? imageFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (imageFile == null) {
      return;
    }

    setState(() {
      _imageFile = File(imageFile.path);
    });
    widget.setImageFile(_imageFile);
  }
}
