import 'dart:convert';

import 'package:home_screen_codes/bloc/bloc_base.dart';
import 'package:home_screen_codes/domain/entity/code_data.dart';
import 'package:home_screen_codes/domain/entity/codes.dart';
import 'package:home_screen_codes/extension/intent_type.dart';
import 'package:home_widget/home_widget.dart';
import 'package:rxdart/subjects.dart';
import 'package:home_screen_codes/extension/string.dart';

class CodesBloc extends BlocBase {
  final _codesController = BehaviorSubject<Codes>.seeded(Codes.empty());

  Stream<Codes> get codes => _codesController.stream;

  @override
  void dispose() {
    _codesController.close();
  }

  @override
  void initState() async {
    HomeWidget.registerBackgroundCallback(backgroundCallback);
    HomeWidget.widgetClicked.listen((_) => _loadData());
    await _loadData();

    _codesController.listen((newCodes) {
      _updateAppWidget(newCodes);
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

  void addCodeData(CodeData codeData) {
    final _codes = _getCurrentCodes('Trying to add data to an empty codes');

    _codes.codesDatas.add(codeData);
    _codesController.add(_codes);
  }

  void onOrderChange(int oldIndex, int newIndex) {
    final _codes = _getCurrentCodes('Trying to order an empty codes');

    // we copy current codesDatas
    final _newCodesDatas = [..._codes.codesDatas];
    // then we update the order
    final _codeData = _newCodesDatas.removeAt(oldIndex);
    final finalNewIndex = oldIndex < newIndex ? newIndex - 1 : newIndex;
    _newCodesDatas.insert(finalNewIndex, _codeData);

    final _newCodes = _codes.copyWith(codesDatas: _newCodesDatas);
    _codesController.add(_newCodes);
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

  Codes _getCurrentCodes(String exceptionMessage) {
    final _codes = _codesController.valueOrNull;
    if (_codes == null) {
      throw Exception(exceptionMessage);
    }

    return _codes;
  }
}
