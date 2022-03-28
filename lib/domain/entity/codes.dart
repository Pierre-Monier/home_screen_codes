import 'package:home_screen_codes/domain/entity/code_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'codes.g.dart';

@JsonSerializable()
class Codes {
  Codes({required this.codesDatas, this.currentIndex = 0});

  factory Codes.fromJson(Map<String, dynamic> json) => _$CodesFromJson(json);
  factory Codes.empty() => Codes(
        codesDatas: List.empty(growable: true),
      );

  final List<CodeData> codesDatas;
  // this should only be set in backgroundCallback
  int currentIndex;

  void updateIndex(IntentType intentType) {
    if (intentType == IntentType.next) {
      _next();
    } else if (intentType == IntentType.previous) {
      _previous();
    }
  }

  void removeCodeData(CodeData codeData) {
    codesDatas.remove(codeData);

    if (currentIndex >= codesDatas.length) {
      currentIndex = codesDatas.length - 1;
    }
  }

  void _next() {
    if (codesDatas.length <= 1) {
      return;
    } else if (currentIndex == codesDatas.length - 1) {
      currentIndex = 0;
    } else {
      currentIndex++;
    }
  }

  void _previous() {
    if (codesDatas.length <= 1) {
      return;
    } else if (currentIndex == 0) {
      currentIndex = codesDatas.length - 1;
    } else {
      currentIndex--;
    }
  }

  // for now we ignore the const keyword because we can't add data to codesDatas
  // with const constructor
  // ignore: prefer_const_constructors

  Map<String, dynamic> toJson() => _$CodesToJson(this);

  Codes copyWith({List<CodeData>? codesDatas, int? currentIndex}) => Codes(
        codesDatas: codesDatas ?? this.codesDatas,
        currentIndex: currentIndex ?? this.currentIndex,
      );
}

enum IntentType { next, previous }
