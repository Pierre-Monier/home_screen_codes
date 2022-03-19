import 'package:json_annotation/json_annotation.dart';

part 'code_data.g.dart';

@JsonSerializable()
class CodeData {
  const CodeData({required this.imagePath, this.labelText = defaultLabelText});

  factory CodeData.fromJson(Map<String, dynamic> json) =>
      _$CodeDataFromJson(json);

  static const defaultLabelText = 'Default text';

  final String imagePath;
  final String labelText;

  Map<String, dynamic> toJson() => _$CodeDataToJson(this);
}
