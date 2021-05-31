// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Size.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Size _$SizeFromJson(Map<String, dynamic> json) {
  return Size(
    width: (json['width'] as num)?.toDouble(),
    height: (json['height'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$SizeToJson(Size instance) => <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
    };
