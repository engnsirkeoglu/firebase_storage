import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

abstract class IImageCompress {
  Future<File?> compressImage({required String filePath});
}

class ImageCompress extends IImageCompress {
  @override
  Future<File?> compressImage({required String filePath}) async {
    final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
    final outPath = '${filePath.substring(0, lastIndex)}_compressed.jpg';

    final compressedImage = await FlutterImageCompress.compressAndGetFile(
      filePath,
      outPath,
      quality: 50,
    );

    return compressedImage;
  }
}
