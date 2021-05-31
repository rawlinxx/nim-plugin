import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'Result.g.dart';

@JsonSerializable(explicitToJson: true)
class Result {
  bool success;
  String payload;

  Result({
    this.success,
    this.payload,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
  Map<String, dynamic> toJson() => _$ResultToJson(this);

  factory Result.parse(String content) => Result.fromJson(json.decode(content));

  Future<T> unbox<T>(T parser(String payload)) {
    if (success) {
      return Future.value(parser(payload));
    } else {
      return Future.error(payload);
    }
  }

  log() {
    print("[Result] ${success ? "✅" : "❌"} payload: $payload");
  }
}
