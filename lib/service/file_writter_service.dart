import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:home_screen_codes/extension/file.dart';

class FileWritterService {
  Future<File> copyFile(File sourceFile) async {
    final appDir = await getApplicationDocumentsDirectory();
    final destFilePath = appDir.path + sourceFile.filename;

    return sourceFile.copy(destFilePath);
  }

  Future<void> deleteFileOnDisk(File file) {
    return file.delete();
  }
}
