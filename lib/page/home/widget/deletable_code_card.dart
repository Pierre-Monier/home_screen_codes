import 'package:flutter/material.dart';
import 'package:home_screen_codes/domain/entity/code_data.dart';
import 'package:home_screen_codes/page/home/widget/code_card_image_deletable.dart';
import 'package:home_screen_codes/page/home/widget/code_label_text_editor.dart';

class DeletableCodeCard extends StatelessWidget {
  const DeletableCodeCard({
    required this.codeData,
    required this.isDeletable,
    Key? key,
  }) : super(key: key);

  final CodeData codeData;
  final bool isDeletable;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        key: key,
        builder: (context, constraints) => Card(
          child: Column(
            children: [
              CodeCardImageDeletable(
                codeData: codeData,
                isDeletable: isDeletable,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: CodeLabelTextEditor(
                  codeData: codeData,
                  canEdit: false,
                ),
              ),
            ],
          ),
        ),
      );
}
