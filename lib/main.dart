import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:home_screen_codes/domain/entity/code_data.dart';
import 'package:home_screen_codes/domain/entity/codes.dart';
import 'package:home_screen_codes/service/file_writter_service.dart';
import 'package:home_screen_codes/service/image_picker_service.dart';
import 'package:home_screen_codes/service_locator.dart';
import 'package:home_widget/home_widget.dart';

// Called when Doing Background Work initiated from Widget
Future<void> backgroundCallback(Uri? uri) async {
  if (uri != null && uri.host == 'updatecounter') {
    int _codes;
    final value =
        await HomeWidget.getWidgetData<int>('_codes', defaultValue: 0);
    _codes = value ?? 0;
    _codes++;
    await HomeWidget.saveWidgetData<int>('_codes', _codes);
    await HomeWidget.updateWidget(
        name: 'AppWidgetProvider', iOSName: 'AppWidgetProvider');
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  HomeWidget.registerBackgroundCallback(backgroundCallback);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Codes? _codes;

  @override
  void initState() {
    super.initState();
    HomeWidget.widgetClicked.listen((_) => loadData());
    loadData(); // This will load data from widget every time app is opened
  }

  void loadData() async {
    await HomeWidget.getWidgetData<String>('_codes', defaultValue: "")
        .then((value) {
      if (value != null && value.isNotEmpty) {
        _codes = Codes.fromJson(json.decode(value) as Map<String, dynamic>);
      } else {
        _codes = Codes.empty();
      }
    });
    setState(() {});
  }

  Future<void> updateAppWidget() async {
    await HomeWidget.saveWidgetData<String>(
        '_codes', json.encode(_codes?.toJson()));
    await HomeWidget.updateWidget(
        name: 'AppWidgetProvider', iOSName: 'AppWidgetProvider');
  }

  Future<void> _pickImageUri() async {
    final imagePath =
        await sl.get<ImagePickerSerivce>().getImagePathFromGallery();

    if (imagePath != null) {
      final imageFile =
          await sl.get<FileWritterService>().copyFile(File(imagePath));
      setState(() {
        _codes?.codesDatas.add(CodeData(imagePath: imageFile.path));
      });
      updateAppWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _codes?.codesDatas
                  .map<Widget>(
                      (codeData) => Image.file(File(codeData.imagePath)))
                  .toList() ??
              [],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImageUri,
        tooltip: 'Pick image',
        child: const Icon(Icons.image),
      ),
    );
  }
}
