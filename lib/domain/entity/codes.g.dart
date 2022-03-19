// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'codes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Codes _$CodesFromJson(Map<String, dynamic> json) => Codes(
      codesDatas: (json['codesDatas'] as List<dynamic>)
          .map((e) => CodeData.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentIndex: json['currentIndex'] as int? ?? 0,
    );

Map<String, dynamic> _$CodesToJson(Codes instance) => <String, dynamic>{
      'codesDatas': instance.codesDatas,
      'currentIndex': instance.currentIndex,
    };
