import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:nim/model/Message.dart';
import 'package:nim/model/Session.dart';
part 'RecentSession.g.dart'; 

@JsonSerializable(explicitToJson: true)
class RecentSession {
    Map localExt;
    double updateTime;
    Session session;
    int unreadCount;
    Message lastMessage;
    String serverExt;
    
    RecentSession({
        this.localExt, 
        this.updateTime, 
        this.session, 
        this.unreadCount, 
        this.lastMessage, 
        this.serverExt, 
    });

  factory RecentSession.fromJson(Map<String, dynamic> json) => _$RecentSessionFromJson(json);
  Map<String, dynamic> toJson() => _$RecentSessionToJson(this);

  factory RecentSession.parse(String content) =>
      RecentSession.fromJson(json.decode(content));

  static List<RecentSession> parseList(String content) {
    Iterable list = json.decode(content);
    return List<RecentSession>.from(list.map((e) => RecentSession.fromJson(e)));
  }
}

