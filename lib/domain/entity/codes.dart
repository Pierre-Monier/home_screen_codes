import "package:home_screen_codes/domain/entity/code_data.dart";
import "package:json_annotation/json_annotation.dart";

part "codes.g.dart";

@JsonSerializable()
class Codes {
  const Codes({required this.codesDatas});

  factory Codes.fromJson(Map<String, dynamic> json) => _$CodesFromJson(json);
  factory Codes.empty() => const Codes(codesDatas: []);

  final List<CodeData> codesDatas;

  // for now we ignore the const keyword because we can't add data to codesDatas
  // with const constructor
  // ignore: prefer_const_constructors

  Map<String, dynamic> toJson() => _$CodesToJson(this);
}
