import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

abstract class IStorageService {
  Future<String?> uploadImage({required File? file, required String? path});
}

class FirebaseStorageService implements IStorageService {
  // Firebase Storage Service Reference
  final _storageRef = FirebaseStorage.instance.ref();

  // Resim Yükleme Kısmıdır.
  @override
  Future<String?> uploadImage(
      {required File? file, required String? path}) async {
    if (file != null && path != null) {
      try {
        var imageRef = _storageRef.child(path);
        await imageRef.putFile(file);
        return await imageRef.getDownloadURL();
      } catch (e) {
        throw e.toString();
      }
    }
  }
}
