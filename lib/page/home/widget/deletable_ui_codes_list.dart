import 'package:flutter/material.dart';
import 'package:home_screen_codes/bloc/codes_bloc.dart';
import 'package:home_screen_codes/page/home/widget/deletable_code_card.dart';

class DeletableUICodesList extends StatelessWidget {
  const DeletableUICodesList({
    required this.uiCodes,
    required this.scrollController,
    Key? key,
  }) : super(key: key);

  final UICodes uiCodes;
  final ScrollController scrollController;

  List<Widget> _getItems() {
    final widgets = <Widget>[];
    var i = 0;

    for (final codeData in uiCodes.keys) {
      widgets.add(
        DeletableCodeCard(
          codeData: codeData,
          key: Key('$i'),
          isDeletable: uiCodes[codeData] ?? false,
        ),
      );
      i++;
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) => ListView(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        children: _getItems(),
      );
}
