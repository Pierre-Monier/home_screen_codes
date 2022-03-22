import 'package:flutter/material.dart';
import 'package:home_screen_codes/bloc/bloc_provider.dart';
import 'package:home_screen_codes/bloc/codes_bloc.dart';
import 'package:home_screen_codes/page/loading/loading_view.dart';

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
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoadingView(),
                  ),
                );
                await BlocProvider.of<CodesBloc>(context)
                    .importCodeFromCamera();
                // TODO fix this gap
                Navigator.pop(context);
                // Navigator.popUntil(context, ModalRoute.withName('/home'));
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                BlocProvider.of<CodesBloc>(context).importCodeFromGallery();
              },
            ),
          ],
        ),
      );
}
