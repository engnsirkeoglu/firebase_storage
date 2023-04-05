import 'package:image_picker/image_picker.dart';

abstract class IPickImage {
  Future<XFile?> pickImage();
  Future<XFile?> capturePhoto();
}

class PickImageCustom implements IPickImage {
  final ImagePicker _picker = ImagePicker();
  @override
  Future<XFile?> capturePhoto() =>
      _picker.pickImage(source: ImageSource.camera);

  @override
  Future<XFile?> pickImage() => _picker.pickImage(source: ImageSource.gallery);
}
