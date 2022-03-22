import 'dart:io';

import 'package:image_cropper/image_cropper.dart';

class ImageCropperService {
  final _imageCropper = ImageCropper();

  Future<File?> cropFile(String sourcePath) {
    return _imageCropper.cropImage(sourcePath: sourcePath);
  }
}
