import 'package:flutter/material.dart';
import 'package:home_screen_codes/bloc/bloc_provider.dart';
import 'package:home_screen_codes/bloc/codes_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SourcePickerDialog extends StatelessWidget {
  const SourcePickerDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('Select source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                BlocProvider.of<CodesBloc>(context)
                    .importCode(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                BlocProvider.of<CodesBloc>(context)
                    .importCode(ImageSource.gallery);
              },
            ),
          ],
        ),
      );
}
