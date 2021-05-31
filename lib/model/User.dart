import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:nim/model/UserInfo.dart';
part 'User.g.dart';


@JsonSerializable(explicitToJson: true)
class User {
  String ext;
  String alias;
  String userId;
  UserInfo userInfo;
  String serverExt;

  User({
    this.ext,
    this.alias,
    this.userId,
    this.userInfo,
    this.serverExt,
  });

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory User.parse(String content) =>
      User.fromJson(json.decode(content));

  static List<User> parseList(String content) {
    Iterable list = json.decode(content);
    return List<User>.from(list.map((e) => User.fromJson(e)));
  }
}
