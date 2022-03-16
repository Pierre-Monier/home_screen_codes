import "package:json_annotation/json_annotation.dart";

part "code_data.g.dart";

@JsonSerializable()
class CodeData {
  const CodeData({required this.imagePath});

  factory CodeData.fromJson(Map<String, dynamic> json) =>
      _$CodeDataFromJson(json);

  final String imagePath;

  Map<String, dynamic> toJson() => _$CodeDataToJson(this);
}
