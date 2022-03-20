import 'package:image_picker/image_picker.dart';

class ImagePickerSerivce {
  final ImagePicker _picker = ImagePicker();

  Future<String?> getImagePath(ImageSource source) async {
    final xfile = await _picker.pickImage(source: source);
    if (xfile == null) {
      // the user must have cancelled the image selection
      return null;
    }

    return xfile.path;
  }
}
