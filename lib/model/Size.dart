import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'Size.g.dart'; 

@JsonSerializable(explicitToJson: true)
class Size {
    double width;
    double height;
    
    Size({
        this.width, 
        this.height, 
    
    });

  factory Size.fromJson(Map<String, dynamic> json) => _$SizeFromJson(json);
  Map<String, dynamic> toJson() => _$SizeToJson(this);

  factory Size.parse(String content) =>
      Size.fromJson(json.decode(content));
}

