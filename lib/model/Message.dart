
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:nim/model/MixedMessageObject.dart';
import 'package:nim/model/Session.dart';
part 'Message.g.dart'; 

@JsonSerializable(explicitToJson: true)
class Message {
    double timestamp;
    MixedMessageObject messageObject;
    bool isDeleted;
    String repliedMessageServerId;
    String serverID;
    bool isReceivedMsg;
    String threadMessageFrom;
    bool isTeamReceiptSended;
    String text;
    String repliedMessageFrom;
    Map yidunAntiCheating;
    bool isRemoteRead;
    bool isOutgoingMsg;
    Map remoteExt;
    int repliedMessageTime;
    String messageType;
    String callbackExt;
    String deliveryState;
    String apnsContent;
    bool isPlayed;
    bool isBlackListed;
    String threadMessageTo;
    String from;
    String threadMessageId;
    String status;
    String senderClientType;
    String env;
    int threadMessageTime;
    String messageId;
    Map localExt;
    Session session;
    String repliedMessageTo;
    Map messageExt;
    String senderName;
    String attachmentDownloadState;
    String threadMessageServerId;
    int messageSubType;
    String repliedMessageId;
    Map apnsPayload;
    
    Message({
        this.timestamp, 
        this.messageObject, 
        this.isDeleted, 
        this.repliedMessageServerId, 
        this.serverID, 
        this.isReceivedMsg, 
        this.threadMessageFrom, 
        this.isTeamReceiptSended, 
        this.text, 
        this.repliedMessageFrom, 
        this.yidunAntiCheating, 
        this.isRemoteRead, 
        this.isOutgoingMsg, 
        this.remoteExt, 
        this.repliedMessageTime, 
        this.messageType, 
        this.callbackExt, 
        this.deliveryState, 
        this.apnsContent, 
        this.isPlayed, 
        this.isBlackListed, 
        this.threadMessageTo, 
        this.from, 
        this.threadMessageId, 
        this.status, 
        this.senderClientType, 
        this.env, 
        this.threadMessageTime, 
        this.messageId, 
        this.localExt, 
        this.session, 
        this.repliedMessageTo, 
        this.messageExt, 
        this.senderName, 
        this.attachmentDownloadState, 
        this.threadMessageServerId, 
        this.messageSubType, 
        this.repliedMessageId, 
        this.apnsPayload, 
    
    });

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);

  factory Message.parse(String content) =>
      Message.fromJson(json.decode(content));

  static List<Message> parseList(String content) {
    Iterable list = json.decode(content);
    return List<Message>.from(list.map((e) => Message.fromJson(e)));
  }
}