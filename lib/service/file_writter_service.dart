import 'dart:io';

import 'package:home_screen_codes/service/image_compression_service.dart';
import 'package:home_screen_codes/service_locator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:home_screen_codes/extension/file.dart';

class FileWritterService {
  Future<File> copyFile(File sourceFile) async {
    final appDir = await getApplicationDocumentsDirectory();
    final destFilePath = appDir.path + sourceFile.filename;
    final compressedFile =
        await sl.get<ImageCompressionService>().compressAndGetFile(
              sourceFile,
              destFilePath,
            );

    if (compressedFile != null) {
      return compressedFile;
    } else {
      return sourceFile.copy(destFilePath);
    }
  }
}
