// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MixedEventPayload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MixedEventPayload _$MixedEventPayloadFromJson(Map<String, dynamic> json) {
  return MixedEventPayload(
    recentSession: json['recentSession'] == null
        ? null
        : RecentSession.fromJson(json['recentSession'] as Map<String, dynamic>),
    totalUnreadCount: json['totalUnreadCount'] as int,
  );
}

Map<String, dynamic> _$MixedEventPayloadToJson(MixedEventPayload instance) =>
    <String, dynamic>{
      'recentSession': instance.recentSession?.toJson(),
      'totalUnreadCount': instance.totalUnreadCount,
    };
