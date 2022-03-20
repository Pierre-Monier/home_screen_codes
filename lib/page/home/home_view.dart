import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:home_screen_codes/bloc/bloc_provider.dart';
import 'package:home_screen_codes/bloc/codes_bloc.dart';
import 'package:home_screen_codes/domain/entity/code_data.dart';
import 'package:home_screen_codes/domain/entity/codes.dart';
import 'package:home_screen_codes/page/home/widget/code_card.dart';
import 'package:home_screen_codes/service/file_writter_service.dart';
import 'package:home_screen_codes/service/image_picker_service.dart';
import 'package:home_screen_codes/service_locator.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _isFabExtended = true;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_isFabExtended) {
          setState(() {
            _isFabExtended = true;
          });
        }
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isFabExtended) {
          setState(() {
            _isFabExtended = false;
          });
        }
      }
    });
  }

  // TODO(pierre/high): this shoudl'nt be in widget code
  Future<void> _pickImageUri(BuildContext context, Codes codes) async {
    final imagePath =
        await sl.get<ImagePickerSerivce>().getImagePathFromGallery();

    if (imagePath != null) {
      final imageFile =
          await sl.get<FileWritterService>().copyFile(File(imagePath));
      BlocProvider.of<CodesBloc>(context)
          .addCodeData(CodeData(imagePath: imageFile.path));
    }
  }

  List<Widget> _getItems(List<CodeData> codesData) {
    final widgets = <Widget>[];
    var i = 0;

    for (final codeData in codesData) {
      widgets.add(
        CodeCard(codeData: codeData, key: Key('$i')),
      );
      i++;
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final bool _showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title?'),
      ),
      body: StreamBuilder<Codes>(
        stream: BlocProvider.of<CodesBloc>(context).codes,
        builder: (context, snapshot) {
          final _data = snapshot.data;

          if (_data == null || !snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (_data.codesDatas.isEmpty) {
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
            children: _getItems(_data.codesDatas),
          );
        },
      ),
      floatingActionButton: _showFab
          ? StreamBuilder<Codes>(
              stream: BlocProvider.of<CodesBloc>(context).codes,
              builder: (context, snapshot) {
                final _data = snapshot.data;

                if (_data != null) {
                  return FloatingActionButton.extended(
                    label: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) =>
                              FadeTransition(
                        opacity: animation,
                        child: SizeTransition(
                          sizeFactor: animation,
                          axis: Axis.horizontal,
                          child: child,
                        ),
                      ),
                      child: _isFabExtended
                          ? Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(right: 4.0),
                                  child: Icon(Icons.qr_code),
                                ),
                                Text('Import a code')
                              ],
                            )
                          : const Icon(Icons.qr_code),
                    ),
                    onPressed: () => _pickImageUri(context, snapshot.data!),
                    tooltip: 'Import a code',
                    // icon: const Icon(Icons.qr_code_sharp),
                  );
                }

                return const SizedBox();
              },
            )
          : null,
    );
  }
}
