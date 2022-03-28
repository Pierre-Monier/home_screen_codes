import 'dart:io';

import 'package:image_cropper/image_cropper.dart';

class ImageCropperService {
  final _imageCropper = ImageCropper();

  Future<File?> cropFile(String sourcePath) {
    return _imageCropper.cropImage(
      sourcePath: sourcePath,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: const AndroidUiSettings(
        initAspectRatio: CropAspectRatioPreset.square,
      ),
    );
  }
}
