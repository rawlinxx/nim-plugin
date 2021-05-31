// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    ext: json['ext'] as String,
    alias: json['alias'] as String,
    userId: json['userId'] as String,
    userInfo: json['userInfo'] == null
        ? null
        : UserInfo.fromJson(json['userInfo'] as Map<String, dynamic>),
    serverExt: json['serverExt'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'ext': instance.ext,
      'alias': instance.alias,
      'userId': instance.userId,
      'userInfo': instance.userInfo?.toJson(),
      'serverExt': instance.serverExt,
    };
