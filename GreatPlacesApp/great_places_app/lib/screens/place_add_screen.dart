import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/providers.dart';

class PlaceAddScreen extends StatefulWidget {
  static String routeName = '/place-add';

  @override
  State<PlaceAddScreen> createState() => _PlaceAddScreenState();
}

class _PlaceAddScreenState extends State<PlaceAddScreen> {
  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _addressEditingController = TextEditingController();
  ImagePicker imagePicker = ImagePicker();
  File? _imageFile = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.bottomLeft,
          child: Text('Add Place'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _savePlace(context);
            },
            icon: const Icon(
              Icons.save,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextField(
                controller: _nameEditingController,
                decoration: const InputDecoration(
                  label: Text('name'),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: _addressEditingController,
                decoration: const InputDecoration(
                  label: Text('address'),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              _imageFile == null
                  ? Container(
                      height: 300,
                      color: Colors.blueGrey.shade200,
                    )
                  : SizedBox(
                      height: 300,
                      child: Image.file(
                        _imageFile!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: () async {
                  _takePicture();
                },
                child: const Text('Take a picture'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _takePicture() async {
    final XFile? imageFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 500,
    );
    if (imageFile == null) {
      return;
    }

    setState(() {
      _imageFile = File(imageFile.path);
    });
  }

  void _savePlace(BuildContext context) {
    final String name = _nameEditingController.value.text;
    final String address = _addressEditingController.value.text;
    final LocationModel location =
        LocationModel(logtitude: 10, latitude: 10, address: address);
    final PlaceModel newPlace = PlaceModel(
      id: DateTime.now().toString(),
      name: name,
      location: location,
      imageFile: _imageFile!,
    );

    context.read<PlaceListProvider>().addPlace(newPlace);
    Navigator.pop(context);
  }
}
