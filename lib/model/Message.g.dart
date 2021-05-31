// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    timestamp: (json['timestamp'] as num)?.toDouble(),
    messageObject: json['messageObject'] == null
        ? null
        : MixedMessageObject.fromJson(
            json['messageObject'] as Map<String, dynamic>),
    isDeleted: json['isDeleted'] as bool,
    repliedMessageServerId: json['repliedMessageServerId'] as String,
    serverID: json['serverID'] as String,
    isReceivedMsg: json['isReceivedMsg'] as bool,
    threadMessageFrom: json['threadMessageFrom'] as String,
    isTeamReceiptSended: json['isTeamReceiptSended'] as bool,
    text: json['text'] as String,
    repliedMessageFrom: json['repliedMessageFrom'] as String,
    yidunAntiCheating: json['yidunAntiCheating'] as Map<String, dynamic>,
    isRemoteRead: json['isRemoteRead'] as bool,
    isOutgoingMsg: json['isOutgoingMsg'] as bool,
    remoteExt: json['remoteExt'] as Map<String, dynamic>,
    repliedMessageTime: json['repliedMessageTime'] as int,
    messageType: json['messageType'] as String,
    callbackExt: json['callbackExt'] as String,
    deliveryState: json['deliveryState'] as String,
    apnsContent: json['apnsContent'] as String,
    isPlayed: json['isPlayed'] as bool,
    isBlackListed: json['isBlackListed'] as bool,
    threadMessageTo: json['threadMessageTo'] as String,
    from: json['from'] as String,
    threadMessageId: json['threadMessageId'] as String,
    status: json['status'] as String,
    senderClientType: json['senderClientType'] as String,
    env: json['env'] as String,
    threadMessageTime: json['threadMessageTime'] as int,
    messageId: json['messageId'] as String,
    localExt: json['localExt'] as Map<String, dynamic>,
    session: json['session'] == null
        ? null
        : Session.fromJson(json['session'] as Map<String, dynamic>),
    repliedMessageTo: json['repliedMessageTo'] as String,
    messageExt: json['messageExt'] as Map<String, dynamic>,
    senderName: json['senderName'] as String,
    attachmentDownloadState: json['attachmentDownloadState'] as String,
    threadMessageServerId: json['threadMessageServerId'] as String,
    messageSubType: json['messageSubType'] as int,
    repliedMessageId: json['repliedMessageId'] as String,
    apnsPayload: json['apnsPayload'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'timestamp': instance.timestamp,
      'messageObject': instance.messageObject?.toJson(),
      'isDeleted': instance.isDeleted,
      'repliedMessageServerId': instance.repliedMessageServerId,
      'serverID': instance.serverID,
      'isReceivedMsg': instance.isReceivedMsg,
      'threadMessageFrom': instance.threadMessageFrom,
      'isTeamReceiptSended': instance.isTeamReceiptSended,
      'text': instance.text,
      'repliedMessageFrom': instance.repliedMessageFrom,
      'yidunAntiCheating': instance.yidunAntiCheating,
      'isRemoteRead': instance.isRemoteRead,
      'isOutgoingMsg': instance.isOutgoingMsg,
      'remoteExt': instance.remoteExt,
      'repliedMessageTime': instance.repliedMessageTime,
      'messageType': instance.messageType,
      'callbackExt': instance.callbackExt,
      'deliveryState': instance.deliveryState,
      'apnsContent': instance.apnsContent,
      'isPlayed': instance.isPlayed,
      'isBlackListed': instance.isBlackListed,
      'threadMessageTo': instance.threadMessageTo,
      'from': instance.from,
      'threadMessageId': instance.threadMessageId,
      'status': instance.status,
      'senderClientType': instance.senderClientType,
      'env': instance.env,
      'threadMessageTime': instance.threadMessageTime,
      'messageId': instance.messageId,
      'localExt': instance.localExt,
      'session': instance.session?.toJson(),
      'repliedMessageTo': instance.repliedMessageTo,
      'messageExt': instance.messageExt,
      'senderName': instance.senderName,
      'attachmentDownloadState': instance.attachmentDownloadState,
      'threadMessageServerId': instance.threadMessageServerId,
      'messageSubType': instance.messageSubType,
      'repliedMessageId': instance.repliedMessageId,
      'apnsPayload': instance.apnsPayload,
    };
