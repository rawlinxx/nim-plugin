import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:nim/model/Size.dart';
part 'MixedMessageObject.g.dart'; 

@JsonSerializable(explicitToJson: true)
class MixedMessageObject {
// common    
    ///  文件的本地路径
    String path;
    ///  文件的远程路径
    String url;
    ///  文件显示名
    String displayName;
    ///  文件名
    String fileName;
    ///  文件大小
    int fileLength;
    ///  文件MD5
    String md5;

// video / audio
    ///  视频 / 语音时长，毫秒为单位
    int duration;
    /// 视频封面
    String coverPath;
    /// 视频封面
    String coverUrl;
    /// 视频封面尺寸
    Size coverSize;
    
// image
    ///  缩略图
    String thumbPath;
    ///  缩略图
    String thumbUrl;
    ///  图片尺寸
    Size size;
    
  // location
    ///  经度
    double longitude;
    ///  纬度
    double latitude;
    /// 地址标题
    String title;
    
  // tip
    /// 是否是 Tip 类型 
    bool isTip;
    
    
    
    
    MixedMessageObject({
        this.fileName, 
        this.fileLength, 
        this.longitude, 
        this.isTip, 
        this.latitude, 
        this.path, 
        this.title, 
        this.size, 
        this.url, 
        this.thumbPath, 
        this.coverSize, 
        this.thumbUrl, 
        this.duration, 
        this.md5, 
        this.coverPath, 
        this.displayName, 
        this.coverUrl, 
    
    });

  factory MixedMessageObject.fromJson(Map<String, dynamic> json) => _$MixedMessageObjectFromJson(json);
  Map<String, dynamic> toJson() => _$MixedMessageObjectToJson(this);

  factory MixedMessageObject.parse(String content) =>
      MixedMessageObject.fromJson(json.decode(content));
}

