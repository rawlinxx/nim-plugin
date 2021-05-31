// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) {
  return Session(
    sessionId: json['sessionId'] as String,
    sessionType: json['sessionType'] as String,
  );
}

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'sessionId': instance.sessionId,
      'sessionType': instance.sessionType,
    };
