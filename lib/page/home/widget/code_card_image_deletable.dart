import 'package:flutter/material.dart';
import 'package:home_screen_codes/domain/entity/code_data.dart';
import 'package:home_screen_codes/page/home/widget/code_card_image.dart';

class CodeCardImageDeletable extends StatefulWidget {
  const CodeCardImageDeletable({required this.codeData, Key? key})
      : super(key: key);

  final CodeData codeData;

  @override
  State<StatefulWidget> createState() => _CodeCardImageDeletableState();
}

class _CodeCardImageDeletableState extends State<CodeCardImageDeletable> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          CodeCardImage(codeData: widget.codeData),
          Positioned(
            right: 0,
            top: 0,
            child: Checkbox(
              value: _isChecked,
              onChanged: (newValue) {
                setState(() {
                  _isChecked = newValue ?? false;
                });
              },
            ),
          )
        ],
      );
}
