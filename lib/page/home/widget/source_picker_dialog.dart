import 'package:flutter/material.dart';
import 'package:home_screen_codes/bloc/bloc_provider.dart';
import 'package:home_screen_codes/bloc/codes_bloc.dart';
import 'package:home_screen_codes/page/home/home_view.dart';
import 'package:home_screen_codes/page/loading/loading_view.dart';
import 'package:image_picker/image_picker.dart';

class SourcePickerDialog extends StatefulWidget {
  const SourcePickerDialog({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SourcePickerDialogState();
}

class _SourcePickerDialogState extends State<SourcePickerDialog> {
  Future<void> _onTap({required ImageSource imageSource}) async {
    Navigator.pushNamed(context, LoadingView.routeName);
    await BlocProvider.of<CodesBloc>(context).importCode(imageSource);

    if (!mounted) return;
    Navigator.popUntil(
      context,
      (route) => route.settings.name == HomeView.routeName,
    );
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('Select source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () => _onTap(imageSource: ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () => _onTap(imageSource: ImageSource.gallery),
            ),
          ],
        ),
      );
}
