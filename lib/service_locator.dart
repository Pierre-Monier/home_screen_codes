import 'package:get_it/get_it.dart';
import 'package:home_screen_codes/service/file_writter_service.dart';
import 'package:home_screen_codes/service/image_cropper_service.dart';
import 'package:home_screen_codes/service/image_picker_service.dart';

final sl = GetIt.instance;

void setupLocator() {
  _configSerivce();
}

void _configSerivce() {
  sl
    ..registerLazySingleton<ImagePickerSerivce>(() => ImagePickerSerivce())
    ..registerLazySingleton<FileWritterService>(() => FileWritterService())
    ..registerLazySingleton<ImageCropperService>(() => ImageCropperService());
}
