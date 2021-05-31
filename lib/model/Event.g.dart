// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event(
    type: json['type'] as String,
    payload: json['payload'] == null
        ? null
        : MixedEventPayload.fromJson(json['payload'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'type': instance.type,
      'payload': instance.payload?.toJson(),
    };
