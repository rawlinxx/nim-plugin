// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RecentSession.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentSession _$RecentSessionFromJson(Map<String, dynamic> json) {
  return RecentSession(
    localExt: json['localExt'] as Map<String, dynamic>,
    updateTime: (json['updateTime'] as num)?.toDouble(),
    session: json['session'] == null
        ? null
        : Session.fromJson(json['session'] as Map<String, dynamic>),
    unreadCount: json['unreadCount'] as int,
    lastMessage: json['lastMessage'] == null
        ? null
        : Message.fromJson(json['lastMessage'] as Map<String, dynamic>),
    serverExt: json['serverExt'] as String,
  );
}

Map<String, dynamic> _$RecentSessionToJson(RecentSession instance) =>
    <String, dynamic>{
      'localExt': instance.localExt,
      'updateTime': instance.updateTime,
      'session': instance.session?.toJson(),
      'unreadCount': instance.unreadCount,
      'lastMessage': instance.lastMessage?.toJson(),
      'serverExt': instance.serverExt,
    };
