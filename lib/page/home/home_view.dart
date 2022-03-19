import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:home_screen_codes/bloc/codes_bloc.dart';
import 'package:home_screen_codes/domain/entity/code_data.dart';
import 'package:home_screen_codes/domain/entity/codes.dart';
import 'package:home_screen_codes/service/file_writter_service.dart';
import 'package:home_screen_codes/service/image_picker_service.dart';
import 'package:home_screen_codes/service_locator.dart';
import 'package:home_widget/home_widget.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  Future<void> updateAppWidget(Codes codes) async {
    await HomeWidget.saveWidgetData<String>(
      '_codes',
      json.encode(codes.toJson()),
    );
    await HomeWidget.updateWidget(
      name: 'AppWidgetProvider',
      iOSName: 'AppWidgetProvider',
    );
  }

  Future<void> _pickImageUri(BuildContext context, Codes codes) async {
    final imagePath =
        await sl.get<ImagePickerSerivce>().getImagePathFromGallery();

    if (imagePath != null) {
      final imageFile =
          await sl.get<FileWritterService>().copyFile(File(imagePath));
      Provider.of<CodesBloc>(context, listen: false)
          .addCodeData(CodeData(imagePath: imageFile.path));
      updateAppWidget(codes);
    }
  }

  List<Widget> _getItems(List<CodeData> codesData) {
    final widgets = <Widget>[];
    var i = 0;

    for (final codeData in codesData) {
      widgets.add(
        ListTile(
          key: Key('$i'),
          tileColor: Colors.amber,
          title: Text(codeData.labelText, key: Key('$i')),
        ),
      );
      i++;
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title?'),
      ),
      body: StreamBuilder<Codes>(
        stream: Provider.of<CodesBloc>(context).codes,
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
            padding: const EdgeInsets.symmetric(horizontal: 40),
            onReorder: ((oldIndex, newIndex) {}),
            children: _getItems(_data.codesDatas),
          );
        },
      ),
      floatingActionButton: StreamBuilder<Codes>(
        stream: Provider.of<CodesBloc>(context).codes,
        builder: (context, snapshot) {
          final _data = snapshot.data;

          if (_data != null) {
            return FloatingActionButton(
              onPressed: () => _pickImageUri(context, snapshot.data!),
              tooltip: 'Pick image',
              child: const Icon(Icons.image),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}