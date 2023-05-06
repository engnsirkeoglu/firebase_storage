import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutterstorage/firebase_storage_service_manager.dart';
import 'package:flutterstorage/pick_image_manager.dart';
import 'package:image_cropper/image_cropper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String _appBarTitle = 'Storage Kullanımı';
  final String _mediaTitle = 'Gallery';
  File? _image;
  CroppedFile? _image2;
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
              final _image = await PickManager().fetchImageWithMediaLibrary();
              if (_image != null) {
                imageURL = await FirebaseStorageServiceManager()
                    .uploadBumuPhotos(file: _image);
                print(imageURL);
                setState(() {});
              }
            },
            icon: const Icon(Icons.perm_media_rounded),
            label: Text(_mediaTitle),
          ),
          _FutureByteImage(image: _image), // Sorunlu Kısım
          _ByteImage(image: _image2),
        ],
      ),
    );
  }
}

class _FutureByteImage extends StatelessWidget {
  const _FutureByteImage({
    required File? image,
  }) : _image = image;

  final File? _image;

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

class _ByteImage extends StatelessWidget {
  const _ByteImage({
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
