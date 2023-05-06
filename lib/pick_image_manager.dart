import 'dart:io';

import 'package:flutterstorage/app_permission_check.dart';
import 'package:flutterstorage/custom_image_cropper_.dart';
import 'package:flutterstorage/pick_image_custom.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_settings/app_settings.dart';

import 'custom_image_compress.dart';

abstract class IPickManager {
  final IAppPermissionCheck permissionCheck = AppPermissionCheck();
  final IPickImage pickImageCustom = PickImageCustom();
  Future<File?> fetchImageWithMediaLibrary();
  Future<File?> fetchImageWithCamera();
}

class PickManager extends IPickManager {
  @override
  Future<File?> fetchImageWithCamera() async {
    if (!await permissionCheck.permissionCamera()) {
      await AppSettings.openAppSettings();
      return null;
    }
    XFile? file = await pickImageCustom.capturePhoto();
    return await _getImage(file);
  }

  @override
  Future<File?> fetchImageWithMediaLibrary() async {
    if (!await permissionCheck.permissionMediaLibrary()) {
      await AppSettings.openAppSettings();
      return null;
    }
    XFile? file = await pickImageCustom.pickImage();
    return await _getImage(file);
  }

  Future<File?> _getImage(XFile? image) async {
    if (image != null) {
      CroppedFile? croppedImage = await ImageCrop().imageCrop(path: image.path);
      if (croppedImage != null) {
        return await ImageCompress().compressImage(filePath: croppedImage.path);
      }
    }
    return null;
  }
}
