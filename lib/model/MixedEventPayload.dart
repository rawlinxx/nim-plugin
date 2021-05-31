import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:nim/model/RecentSession.dart';
part 'MixedEventPayload.g.dart';

@JsonSerializable(explicitToJson: true)
class MixedEventPayload {
  RecentSession recentSession;
  int totalUnreadCount;

  MixedEventPayload({
    this.recentSession,
    this.totalUnreadCount,
  });

  factory MixedEventPayload.fromJson(
          Map<String, dynamic> json) =>
      _$MixedEventPayloadFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MixedEventPayloadToJson(this);

  factory MixedEventPayload.parse(String content) =>
      MixedEventPayload.fromJson(json.decode(content));
}

