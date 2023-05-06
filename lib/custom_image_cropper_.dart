import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

abstract class IImageCrop {
  Future<CroppedFile?> imageCrop({required String path});
}

class ImageCrop implements IImageCrop {
  @override
  Future<CroppedFile?> imageCrop({required String path}) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Bumula',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Bumula',
        ),
      ],
    );
    return croppedFile;
  }
}
