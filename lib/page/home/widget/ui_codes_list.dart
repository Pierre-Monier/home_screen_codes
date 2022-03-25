import 'package:flutter/material.dart';
import 'package:home_screen_codes/bloc/bloc_provider.dart';
import 'package:home_screen_codes/bloc/codes_bloc.dart';
import 'package:home_screen_codes/page/home/widget/code_card.dart';

class UICodesList extends StatelessWidget {
  const UICodesList({
    required this.uiCodes,
    required this.scrollController,
    Key? key,
  }) : super(key: key);

  final UICodes uiCodes;
  final ScrollController scrollController;

  List<Widget> _getItems(BuildContext context) {
    final widgets = <Widget>[];
    var i = 0;

    for (final codeData in uiCodes.keys) {
      widgets.add(
        CodeCard(
          key: Key('$i'),
          codeData: codeData,
          isDeletable: uiCodes[codeData] ?? false,
        ),
      );
      i++;
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) => ReorderableListView(
        scrollController: scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        onReorder: ((oldIndex, newIndex) {
          BlocProvider.of<CodesBloc>(context).onOrderChange(oldIndex, newIndex);
        }),
        children: _getItems(context),
      );
}
