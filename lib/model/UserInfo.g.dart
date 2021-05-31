// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo(
    gender: json['gender'] as String,
    mobile: json['mobile'] as String,
    thumbAvatarUrl: json['thumbAvatarUrl'] as String,
    ext: json['ext'] as String,
    birth: json['birth'] as String,
    avatarUrl: json['avatarUrl'] as String,
    email: json['email'] as String,
    sign: json['sign'] as String,
    nickName: json['nickName'] as String,
  );
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'gender': instance.gender,
      'mobile': instance.mobile,
      'thumbAvatarUrl': instance.thumbAvatarUrl,
      'ext': instance.ext,
      'birth': instance.birth,
      'avatarUrl': instance.avatarUrl,
      'email': instance.email,
      'sign': instance.sign,
      'nickName': instance.nickName,
    };
