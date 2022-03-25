import 'dart:io';

import 'package:flutter/material.dart';
import 'package:home_screen_codes/domain/entity/code_data.dart';
import 'package:photo_view/photo_view.dart';

class DetailView extends StatelessWidget {
  const DetailView({required this.codeData, Key? key}) : super(key: key);

  final CodeData codeData;

  static const routeName = '/detail';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(codeData.labelText),
        ),
        body: Center(
          child: PhotoView(
            imageProvider: FileImage(File(codeData.imagePath)),
          ),
        ),
      );
}
