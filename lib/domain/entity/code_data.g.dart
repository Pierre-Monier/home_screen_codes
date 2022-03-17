// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'code_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CodeData _$CodeDataFromJson(Map<String, dynamic> json) => CodeData(
      imagePath: json['imagePath'] as String,
      labelText: json['labelText'] as String? ?? defaultLabelText,
    );

Map<String, dynamic> _$CodeDataToJson(CodeData instance) => <String, dynamic>{
      'imagePath': instance.imagePath,
      'labelText': instance.labelText,
    };
