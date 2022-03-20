import 'dart:io';

import 'package:flutter/material.dart';
import 'package:home_screen_codes/domain/entity/code_data.dart';

class CodeCardImage extends StatelessWidget {
  const CodeCardImage({required this.codeData, Key? key}) : super(key: key);

  final CodeData codeData;

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height / 3,
        ),
        child: Image.file(File(codeData.imagePath)),
      );
}
