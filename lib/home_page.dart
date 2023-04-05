import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutterstorage/enum/storage_folder_enum.dart';
import 'package:flutterstorage/firebase_storage_service_manager.dart';
import 'package:flutterstorage/image_cropper_manager.dart';
import 'package:flutterstorage/pick_image_manager.dart';
import 'package:flutterstorage/service/firebase_storage_service.dart';
import 'package:flutterstorage/uuid_generator.dart';
import 'package:image_cropper/image_cropper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String _appBarTitle = 'Storage Kullanımı';
  final String _mediaTitle = 'Gallery';
  CroppedFile? _image;
  String? imageURL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: Column(
        children: [
          ElevatedButton.icon(
            onPressed: () async {
              final image = await PickManager().fetchImageWithMediaLibrary();
              if (image != null) {
                _image = await ImageCrop().imageCrop(path: image.path);
                imageURL = await FirebaseStorageServiceManager()
                    .uploadImage(croppedImagePath: _image!.path);
                String? imageName = FirebaseStorageServiceManager()
                    .getImagePath(imageURL: imageURL);
                print(imageName); // prints 'myimage.jpg'
              }
              setState(() {});
            },
            icon: const Icon(Icons.perm_media_rounded),
            label: Text(_mediaTitle),
          ),
          ElevatedButton(
              onPressed: () {
                FirebaseStorageServiceManager().deleteImage(imageURL: imageURL);
                setState(() {});
              },
              child: Text('Sil')),
          _FutureByteImage(image: _image)
        ],
      ),
    );
  }
}

class _FutureByteImage extends StatelessWidget {
  const _FutureByteImage({
    super.key,
    required CroppedFile? image,
  }) : _image = image;

  final CroppedFile? _image;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _image?.readAsBytes(),
      builder: (context, AsyncSnapshot<Uint8List?> snapshot) {
        if (snapshot.hasData) {
          return Image.memory(snapshot.data!);
        }
        return const SizedBox();
      },
    );
  }
}
