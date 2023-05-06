import 'dart:io';

import 'package:flutterstorage/service/firebase_storage_service.dart';
import 'package:intl/intl.dart';

class FirebaseStorageServiceManager {
  Future<String?> uploadProfilPhoto({required File file}) async {
    String path = 'images/uid/profilPhotos/${_generateImageName()}';
    return await FirebaseStorageService().uploadImage(file: file, path: path);
  }

  Future<String?> uploadBumuPhotos({required File file}) async {
    String path = 'images/uid/bumuPhotos/bumuId/${_generateImageName()}';
    return await FirebaseStorageService().uploadImage(file: file, path: path);
  }

  String _generateImageName() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyyMMdd_HHmmss_SSS');
    final timestamp = formatter.format(now);
    final imageName = '$timestamp.png';
    return imageName;
  }
}
