import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'Session.g.dart'; 

@JsonSerializable(explicitToJson: true)
class Session {
    String sessionId;
    String sessionType;
    
    Session({
        this.sessionId, 
        this.sessionType, 
    
    });

  factory Session.fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);
  Map<String, dynamic> toJson() => _$SessionToJson(this);

  factory Session.parse(String content) =>
      Session.fromJson(json.decode(content));
}

