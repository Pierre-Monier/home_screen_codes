import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageCompressionService {
  Future<File?> compressAndGetFile(File file, String targetPath) {
    return FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 50,
    );
  }
}
