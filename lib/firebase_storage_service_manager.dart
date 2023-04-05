import 'dart:io';

import 'package:flutterstorage/service/firebase_storage_service.dart';
import 'mixin/image_name_generator_mixin.dart';

class FirebaseStorageServiceManager with RandomImageNameGenerator {
  final FirebaseStorageService storageService = FirebaseStorageService();
  // Resmi yükleyen fonksiyon
  @override
  Future<String?> uploadImage({required String? croppedImagePath}) async {
    if (croppedImagePath != null) {
      File file = File(croppedImagePath);
      String? imageURL = await storageService.uploadImage(
          file: file, imageName: getRandomImageName());
      return imageURL;
    }
  }

  // Resim yolunu veren fonksiyon
  String? getImagePath({required String? imageURL}) {
    if (imageURL != null) {
      final Uri uri = Uri.parse(imageURL);
      final String imagePath = uri.pathSegments.last;
      return imagePath;
    }
    return null;
  }

  Future<void> deleteImage({required String? imageURL}) async {
    await storageService.deleteImage(
        imagePath: getImagePath(imageURL: imageURL));
  }
}
