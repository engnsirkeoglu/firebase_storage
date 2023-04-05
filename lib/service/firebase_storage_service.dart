import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import '../enum/storage_folder_enum.dart';

abstract class IStorageService {
  Future<String?> uploadImage(
      {required File? file, required String? imageName});
  Future<void> deleteImage({required String? imagePath});
}

class FirebaseStorageService implements IStorageService {
  // Firebase Storage Service Reference
  final _storageRef = FirebaseStorage.instance.ref();

  // Firebase Storage Service Images Folder Reference
  Reference get _imagesFolderRef =>
      _storageRef.child(StorageFolder.images.folderName);

  // Resim Yükleme Kısmıdır.
  @override
  Future<String?> uploadImage(
      {required File? file, required String? imageName}) async {
    if (file != null && imageName != null) {
      try {
        var imageRef = _imagesFolderRef.child(imageName);
        var uploadTask = await imageRef.putFile(file);
        return await imageRef.getDownloadURL();
      } catch (e) {
        throw 'Resim Yüklenirken Bir Hata Oluştu Lütfen Tekrar Deneyiniz.';
      }
    }
    return null;
  }

  // Resmi storage'dan kalıcı olarak silen fonksiyon
  @override
  Future<void> deleteImage({required String? imagePath}) async {
    if (imagePath != null) {
      try {
        var imageRef = _storageRef.child(imagePath);
        await imageRef.delete();
      } catch (e) {
        throw ('Resim Silinemedi');
      }
    }
  }
}
