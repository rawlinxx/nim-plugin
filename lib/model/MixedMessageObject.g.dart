// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MixedMessageObject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MixedMessageObject _$MixedMessageObjectFromJson(Map<String, dynamic> json) {
  return MixedMessageObject(
    fileName: json['fileName'] as String,
    fileLength: json['fileLength'] as int,
    longitude: (json['longitude'] as num)?.toDouble(),
    isTip: json['isTip'] as bool,
    latitude: (json['latitude'] as num)?.toDouble(),
    path: json['path'] as String,
    title: json['title'] as String,
    size: json['size'] == null
        ? null
        : Size.fromJson(json['size'] as Map<String, dynamic>),
    url: json['url'] as String,
    thumbPath: json['thumbPath'] as String,
    coverSize: json['coverSize'] == null
        ? null
        : Size.fromJson(json['coverSize'] as Map<String, dynamic>),
    thumbUrl: json['thumbUrl'] as String,
    duration: json['duration'] as int,
    md5: json['md5'] as String,
    coverPath: json['coverPath'] as String,
    displayName: json['displayName'] as String,
    coverUrl: json['coverUrl'] as String,
  );
}

Map<String, dynamic> _$MixedMessageObjectToJson(MixedMessageObject instance) =>
    <String, dynamic>{
      'path': instance.path,
      'url': instance.url,
      'displayName': instance.displayName,
      'fileName': instance.fileName,
      'fileLength': instance.fileLength,
      'md5': instance.md5,
      'duration': instance.duration,
      'coverPath': instance.coverPath,
      'coverUrl': instance.coverUrl,
      'coverSize': instance.coverSize?.toJson(),
      'thumbPath': instance.thumbPath,
      'thumbUrl': instance.thumbUrl,
      'size': instance.size?.toJson(),
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'title': instance.title,
      'isTip': instance.isTip,
    };
