import 'package:image_picker/image_picker.dart';

class ImagePickerSerivce {
  final ImagePicker _picker = ImagePicker();

  /// return image path of the selected image
  Future<String?> getImagePathFromGallery() async {
    final xfile = await _picker.pickImage(source: ImageSource.gallery);
    if (xfile == null) {
      // the user must have cancelled the image selection
      return null;
    }

    return xfile.path;
  }
}
