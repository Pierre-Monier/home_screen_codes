import 'dart:io';

extension FileX on File {
  String get filename => path.split(Platform.pathSeparator).last;
}
