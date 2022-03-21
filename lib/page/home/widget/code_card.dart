import 'package:flutter/material.dart';
import 'package:home_screen_codes/domain/entity/code_data.dart';
import 'package:home_screen_codes/page/home/notifier/is_deleting_notifier.dart';
import 'package:home_screen_codes/page/home/widget/code_card_image.dart';
import 'package:home_screen_codes/page/home/widget/code_card_image_deletable.dart';
import 'package:home_screen_codes/page/home/widget/code_label_text_editor.dart';
import 'package:provider/provider.dart';

class CodeCard extends StatelessWidget {
  const CodeCard({
    required this.codeData,
    required this.isDeletable,
    required Key key,
  }) : super(key: key);

  final CodeData codeData;
  final bool isDeletable;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        key: key,
        builder: (context, constraints) => Card(
          child: Consumer<IsDeletingNotifier>(
            builder: (context, notifier, child) => Column(
              children: [
                if (notifier.value)
                  CodeCardImageDeletable(
                    codeData: codeData,
                    isDeletable: isDeletable,
                  )
                else
                  CodeCardImage(codeData: codeData),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: CodeLabelTextEditor(
                    codeData: codeData,
                    canEdit: !notifier.value,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
