import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'UserInfo.g.dart';


@JsonSerializable(explicitToJson: true)
class UserInfo {
  String gender;
  String mobile;
  String thumbAvatarUrl;
  String ext;
  String birth;
  String avatarUrl;
  String email;
  String sign;
  String nickName;

  UserInfo({
    this.gender,
    this.mobile,
    this.thumbAvatarUrl,
    this.ext,
    this.birth,
    this.avatarUrl,
    this.email,
    this.sign,
    this.nickName,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

  factory UserInfo.parse(String content) =>
      UserInfo.fromJson(json.decode(content));
}
