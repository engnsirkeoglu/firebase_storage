import 'package:permission_handler/permission_handler.dart';

abstract class IAppPermissionCheck {
  Future<bool> permissionCamera();
  Future<bool> permissionMediaLibrary();
}

class AppPermissionCheck implements IAppPermissionCheck {
  // Camera access permission check
  @override
  Future<bool> permissionCamera() async {
    return _permissionCheckController(permission: Permission.camera);
  }

  // Media Library access permission check
  @override
  Future<bool> permissionMediaLibrary() async {
    return await _permissionCheckController(permission: Permission.photos);
  }

  // Permission check controller
  Future<bool> _permissionCheckController(
      {required Permission permission}) async {
    var status = await _permissionRequest(permission: permission);
    return status;
  }

  // Permission request
  Future<bool> _permissionRequest({required Permission permission}) async {
    return await permission.request().isGranted;
  }
}
