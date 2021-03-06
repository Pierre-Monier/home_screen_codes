import 'dart:convert';
import 'dart:io';

import 'package:home_screen_codes/bloc/bloc_base.dart';
import 'package:home_screen_codes/domain/entity/code_data.dart';
import 'package:home_screen_codes/domain/entity/codes.dart';
import 'package:home_screen_codes/extension/intent_type.dart';
import 'package:home_screen_codes/service/file_writter_service.dart';
import 'package:home_screen_codes/service/image_cropper_service.dart';
import 'package:home_screen_codes/service/image_picker_service.dart';
import 'package:home_screen_codes/service_locator.dart';
import 'package:home_widget/home_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/subjects.dart';
import 'package:home_screen_codes/extension/string.dart';

typedef UICodes = Map<CodeData, bool>;

class CodesBloc extends BlocBase {
  final _codesController = BehaviorSubject<Codes>.seeded(Codes.empty());

  /// a wrapper on codes, use to set the deletable value
  final _uiCodesController = BehaviorSubject<UICodes>.seeded({});

  Stream<UICodes> get uiCodes => _uiCodesController.stream;

  @override
  void dispose() {
    _codesController.close();
    _uiCodesController.close();
  }

  @override
  void initState() async {
    HomeWidget.registerBackgroundCallback(backgroundCallback);
    HomeWidget.widgetClicked.listen((_) => _loadData());
    await _loadData();

    _codesController.listen((newCodes) {
      _updateAppWidget(newCodes);
      _fillUICodes(newCodes);
    });
  }

  // Called when Doing Background Work initiated from Widget
  static Future<void> backgroundCallback(Uri? uri) async {
    if (uri != null && uri.host.isABackgroundIntent) {
      Codes _codes;
      final value =
          await HomeWidget.getWidgetData<String>('_codes', defaultValue: '');
      if (value != null && value.isNotEmpty) {
        _codes = Codes.fromJson(json.decode(value) as Map<String, dynamic>)
          ..updateIndex(IntentTypeX.fromString(uri.host));

        _updateAppWidget(_codes);
      }
    }
  }

  Future<void> importCode(ImageSource imageSource) async {
    final imagePath =
        await sl.get<ImagePickerSerivce>().getImagePath(imageSource);

    if (imagePath != null) {
      final croppedImage = await sl.get<ImageCropperService>().cropFile(
            imagePath,
          );

      final imageFile = croppedImage ?? File(imagePath);

      final imageOnDisk =
          await sl.get<FileWritterService>().copyFile(imageFile);
      _addCodeData(CodeData(imagePath: imageOnDisk.path));
    }
  }

  void _addCodeData(CodeData codeData) {
    final _codes = _getCurrentCodes('Trying to add data to an empty codes');

    _codes.codesDatas.add(codeData);
    _codesController.add(_codes);
  }

  void onOrderChange(int oldIndex, int newIndex) {
    final _codes = _getCurrentCodes('Trying to order an empty codes');

    final _codeData = _codes.codesDatas.removeAt(oldIndex);
    final finalNewIndex = oldIndex < newIndex ? newIndex - 1 : newIndex;
    _codes.codesDatas.insert(finalNewIndex, _codeData);

    _codesController.add(_codes);
  }

  void updateCodeData({
    required CodeData oldCodeData,
    required CodeData newCodeData,
  }) {
    final _codes = _getCurrentCodes('Trying to update an empty codes');

    final _newCodesData = [..._codes.codesDatas];
    final _index = _codes.codesDatas.indexOf(oldCodeData);
    _newCodesData[_index] = newCodeData;

    final newCodes = _codes.copyWith(codesDatas: _newCodesData);

    _codesController.add(newCodes);
  }

  void updateUICodes({required CodeData codeData, required bool isDeletable}) {
    final _uiCodes = _getCurrentUICodes(
      'trying to update an empty deletable codes',
    );

    _uiCodes[codeData] = isDeletable;
    _uiCodesController.add(_uiCodes);
  }

  void cleanUICodes() {
    final _currentUICodes = _getCurrentUICodes(
      'trying to clean an empty deletable codes data',
    );

    final _newUICodes =
        _currentUICodes.map((key, value) => MapEntry(key, false));

    _uiCodesController.add(_newUICodes);
  }

  void deleteCodesDatas() {
    final _codes = _getCurrentCodes('Trying to delete an empty codes');
    final _uiCodes = _getCurrentUICodes(
      'Trying to delete an empty uiCodes',
    );

    final _shouldBeDeletedCodes = _uiCodes.entries
        .where((uiCode) => uiCode.value)
        .map((deletableCode) => deletableCode.key)
        .toList();

    for (final code in _shouldBeDeletedCodes) {
      sl.get<FileWritterService>().deleteFileOnDisk(File(code.imagePath));
      _codes.removeCodeData(code);
    }

    _codesController.add(_codes);
  }

  static Future<void> _updateAppWidget(Codes codes) async {
    await HomeWidget.saveWidgetData<String>(
      '_codes',
      json.encode(codes.toJson()),
    );
    await HomeWidget.updateWidget(
      name: 'AppWidgetProvider',
      iOSName: 'AppWidgetProvider',
    );
  }

  Future<void> _loadData() async {
    await HomeWidget.getWidgetData<String>('_codes', defaultValue: '')
        .then((value) {
      Codes _codes;

      if (value != null && value.isNotEmpty) {
        _codes = Codes.fromJson(json.decode(value) as Map<String, dynamic>);
      } else {
        _codes = Codes.empty();
      }

      _codesController.add(_codes);
    });
  }

  void _fillUICodes(Codes codes) {
    final UICodes _newUICodes = {};

    for (final codeData in codes.codesDatas) {
      _newUICodes[codeData] = false;
    }

    _uiCodesController.add(_newUICodes);
  }

  Codes _getCurrentCodes(String exceptionMessage) {
    final _codes = _codesController.valueOrNull;
    if (_codes == null) {
      throw Exception(exceptionMessage);
    }

    return _codes;
  }

  UICodes _getCurrentUICodes(String exceptionMessage) {
    final _uiCodes = _uiCodesController.valueOrNull;
    if (_uiCodes == null) {
      throw Exception(exceptionMessage);
    }

    return _uiCodes;
  }
}
