import 'package:flutterstorage/app_permission_check.dart';
import 'package:flutterstorage/pick_image_custom.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_settings/app_settings.dart';

abstract class IPickManager {
  final IAppPermissionCheck permissionCheck = AppPermissionCheck();
  final IPickImage pickImageCustom = PickImageCustom();
  Future<XFile?> fetchImageWithMediaLibrary();
  Future<XFile?> fetchImageWithCamera();
}

class PickManager extends IPickManager {
  @override
  Future<XFile?> fetchImageWithCamera() async {
    if (!await permissionCheck.permissionCamera()) {
      await AppSettings.openAppSettings();
      return null;
    }

    return await pickImageCustom.capturePhoto();
  }

  @override
  Future<XFile?> fetchImageWithMediaLibrary() async {
    if (!await permissionCheck.permissionMediaLibrary()) {
      await AppSettings.openAppSettings();
      return null;
    }
    return await pickImageCustom.pickImage();
  }
}
