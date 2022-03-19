import 'dart:io';

import 'package:flutter/material.dart';
import 'package:home_screen_codes/domain/entity/code_data.dart';
import 'package:home_screen_codes/page/widget/code_label_text_editor.dart';

class CodeCard extends StatelessWidget {
  const CodeCard({required this.codeData, required Key key}) : super(key: key);

  final CodeData codeData;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => Card(
          key: key,
          child: Column(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height / 3,
                ),
                child: Image.file(File(codeData.imagePath)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: CodeLabelTextEditor(codeData: codeData),
              ),
            ],
          ),
        ),
      );
}
