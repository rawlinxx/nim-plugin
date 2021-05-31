// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    success: json['success'] as bool,
    payload: json['payload'] as String,
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'success': instance.success,
      'payload': instance.payload,
    };
