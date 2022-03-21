import 'package:flutter/material.dart';
import 'package:home_screen_codes/bloc/bloc_provider.dart';
import 'package:home_screen_codes/bloc/codes_bloc.dart';
import 'package:home_screen_codes/domain/entity/code_data.dart';
import 'package:home_screen_codes/page/home/widget/code_card_image.dart';

class CodeCardImageDeletable extends StatelessWidget {
  const CodeCardImageDeletable({
    required this.codeData,
    required this.isDeletable,
    Key? key,
  }) : super(key: key);

  final CodeData codeData;
  final bool isDeletable;

  void _updateCheckBox(BuildContext context, bool? newValue) {
    BlocProvider.of<CodesBloc>(context).updateUICodes(
      codeData: codeData,
      isDeletable: newValue ?? false,
    );
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          CodeCardImage(codeData: codeData),
          Positioned(
            right: 0,
            top: 0,
            child: Checkbox(
              value: isDeletable,
              onChanged: (newValue) => _updateCheckBox(context, newValue),
            ),
          )
        ],
      );
}
