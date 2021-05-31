import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:nim/model/MixedEventPayload.dart';
part 'Event.g.dart';

@JsonSerializable(explicitToJson: true)
class Event {
  String type;
  MixedEventPayload payload;

  Event({
    this.type,
    this.payload,
  });

  factory Event.fromJson(Map<String, dynamic> json) =>
      _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);

  factory Event.parse(String content) =>
      Event.fromJson(json.decode(content));
}
