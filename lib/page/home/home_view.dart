import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:home_screen_codes/bloc/bloc_provider.dart';
import 'package:home_screen_codes/bloc/codes_bloc.dart';
import 'package:home_screen_codes/domain/entity/codes.dart';
import 'package:home_screen_codes/page/home/notifier/import_fab_should_extended_notifier.dart';
import 'package:home_screen_codes/page/home/notifier/is_deleting_notifier.dart';
import 'package:home_screen_codes/page/home/widget/code_card.dart';
import 'package:home_screen_codes/page/home/widget/home_view_appbar.dart';
import 'package:home_screen_codes/page/home/widget/import_code_fab.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _isDeleting = IsDeletingNotifier();
  final _isFabExtendedNotifier = ImportFabShouldExtendedNotifier();
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_isFabExtendedNotifier.value) {
          _isFabExtendedNotifier.value = true;
        }
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isFabExtendedNotifier.value) {
          _isFabExtendedNotifier.value = false;
        }
      }
    });
  }

  List<Widget> _getItems(UICodes deletableCodeData) {
    final widgets = <Widget>[];
    var i = 0;

    for (final codeData in deletableCodeData.keys) {
      widgets.add(
        CodeCard(
          codeData: codeData,
          key: Key('$i'),
          isDeletable: deletableCodeData[codeData] ?? false,
        ),
      );
      i++;
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    // TODO(maybe): pass this in a notifier
    final bool _showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<IsDeletingNotifier>.value(
          value: _isDeleting,
        ),
        ChangeNotifierProvider<ImportFabShouldExtendedNotifier>.value(
          value: _isFabExtendedNotifier,
        ),
      ],
      builder: (context, _) => Scaffold(
        appBar: const HomeViewAppbar(),
        body: StreamBuilder<UICodes>(
          stream: BlocProvider.of<CodesBloc>(context).uiCodes,
          builder: (context, snapshot) {
            final _data = snapshot.data;

            if (_data == null || !snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (_data.isEmpty) {
              return const Center(
                child: Text('No Data'),
              );
            }

            return ReorderableListView(
              scrollController: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              onReorder: ((oldIndex, newIndex) {
                BlocProvider.of<CodesBloc>(context)
                    .onOrderChange(oldIndex, newIndex);
              }),
              children: _getItems(_data),
            );
          },
        ),
        floatingActionButton: Consumer<IsDeletingNotifier>(
          builder: (context, notifier, child) => !notifier.value && _showFab
              ? StreamBuilder<Codes>(
                  stream: BlocProvider.of<CodesBloc>(context).codes,
                  builder: (context, snapshot) {
                    final _data = snapshot.data;

                    if (_data != null) {
                      return const ImportCodeFab();
                    }

                    return const SizedBox();
                  },
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
