import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nim/model/Message.dart';
import 'package:nim/model/MixedEventPayload.dart';
import 'package:nim/model/Event.dart';
import 'package:nim/model/enum.dart';
import 'package:nim/model/User.dart';

import 'model/RecentSession.dart';
import 'model/Result.dart';

typedef EventListener = void Function(
    EventType eventType, MixedEventPayload payload);

class Nim {
  static final Nim _instance = Nim._();

  final MethodChannel _methodChannel = const MethodChannel('nim_method');
  final EventChannel _eventChannel = const EventChannel('nim_event');

  EventListener _eventListener;

  Nim._() {
    _eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
  }

  factory Nim() {
    return _instance;
  }
}

extension Observe on Nim {
  void _onEvent(Object content) {
     Event event = Event.parse(content);
    // prettyprint(event);
    if (this._eventListener != null) {
      this._eventListener(EventTypeExt.create(event.type), event.payload);
    }
  }

  void _onError(Object error) {
    print(error);
  }

  _prettyprint(Object obj) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    print("**************** ${obj} ****************");
    print(encoder.convert(obj));
  }
}

extension Api on Nim {
  Future<void> register({
    String appKey,
    String apnsCername,
  }) {
    return _methodChannel.invokeMethod('register', {
      "appKey": appKey,
      "apnsCername": apnsCername,
    });
  }

  Future<Result> login(String account, String token) {
    return _methodChannel.invokeMethod('login', {
      "account": account,
      "token": token,
    }).then((o) => Result.parse(o));
  }

  /// 只能在主线程调用
  Future<List<RecentSession>> allRecentSessions() {
    return _methodChannel
        .invokeMethod('allRecentSessions', {})
        .then((o) => Result.parse(o))
        .then(
            (o) => o.unbox((payload) => RecentSession.parseList(payload)));
  }

/**
 *  从本地db读取一个会话里某条消息之前的若干条的消息
 *
 *  @param session 消息所属的会话
 *  @param message 当前最早的消息,没有则传入nil
 *  @param limit   个数限制
 *
 *  @return 消息列表，按时间从小到大排列
 */
  Future<List<Message>> messagesInSession(
      String sessionId, String messageId, int limit,
      {SessionType sessionType = SessionType.P2P}) {
    return _methodChannel
        .invokeMethod('messagesInSession', {
          "sessionId": sessionId,
          "sessionType": sessionType.rawValue(),
          "messageId": messageId,
          "limit": limit
        })
        .then((o) => Result.parse(o))
        .then((o) => o.unbox((payload) => Message.parseList(payload)));
  }

  // Future<List<RecentsessionsData>> allRecentSessions() {
  //   return _methodChannel
  //       .invokeMethod('allRecentSessions', {})
  //       .then((o) => Result.parse(o))
  //       .then(
  //           (o) => o.unbox((payload) => RecentsessionsData.parseList(payload)));
  // }

  Future<Result> sendTextMessage(String sessionId, String text) {
    return _methodChannel.invokeMethod('sendTextMessage', {
      "sessionId": sessionId,
      "text": text,
    }).then((o) => Result.parse(o));
  }

  Future<Result> sendTipMessage(String sessionId, String text) {
    return _methodChannel.invokeMethod('sendTipMessage', {
      "sessionId": sessionId,
      "text": text,
    }).then((o) => Result.parse(o));
  }

  Future<Result> sendImageMessage(String sessionId, String path) {
    return _methodChannel.invokeMethod('sendImageMessage', {
      "sessionId": sessionId,
      "path": path,
    }).then((o) => Result.parse(o));
  }

  Future<Result> sendAudioMessage(String sessionId, String path) {
    return _methodChannel.invokeMethod('sendAudioMessage', {
      "sessionId": sessionId,
      "path": path,
    }).then((o) => Result.parse(o));
  }

  Future<Result> sendVideoMessage(String sessionId, String path) {
    return _methodChannel.invokeMethod('sendVideoMessage', {
      "sessionId": sessionId,
      "path": path,
    }).then((o) => Result.parse(o));
  }

  Future<Result> sendFileMessage(String sessionId, String path) {
    return _methodChannel.invokeMethod('sendFileMessage', {
      "sessionId": sessionId,
      "path": path,
    }).then((o) => Result.parse(o));
  }

  Future<Result> sendLocationMessage(
      String sessionId, double latitude, double longitude, String title) {
    return _methodChannel.invokeMethod('sendLocationMessage', {
      "sessionId": sessionId,
      "latitude": latitude,
      "longitude": longitude,
      "title": title,
    }).then((o) => Result.parse(o));
  }

  Future<Result> sendCustomMessage(String sessionId, int id, String type) {
    return _methodChannel.invokeMethod('sendCustomMessage', {
      "sessionId": sessionId,
      "id": id,
      "type": type,
    }).then((o) => Result.parse(o));
  }

  Future<Result> markAllMessagesReadInSession(String sessionId) {
    return _methodChannel.invokeMethod('markAllMessagesReadInSession',
        {"sessionId": sessionId}).then((o) => Result.parse(o));
  }

  Future<Result> batchMarkMessagesRead(List<String> sessionIds) {
    return _methodChannel.invokeMethod('batchMarkMessagesRead',
        {"sessionIds": sessionIds}).then((o) => Result.parse(o));
  }

  Future<void> markAllMessagesRead() async {
    await _methodChannel.invokeMethod('markAllMessagesRead', {});
  }

  Future<void> deleteRecentSession(String sessionId) {
    return _methodChannel
        .invokeMethod('deleteRecentSession', {"sessionId": sessionId});
  }

/**
 *  从本地获取用户资料
 *
 *  @param  userId 用户id
 *
 *  @return NIMUser
 *
 *  @discussion 需要将用户信息交给云信托管，且数据已经正常缓存到本地，此接口才有效。
 *              用户资料除自己之外，不保证其他用户资料实时更新
 *              其他用户资料更新的时机为: 1.调用 - (void)fetchUserInfos:completion: 方法刷新用户
 *                                    2.收到此用户发来消息
 *                                    3.程序再次启动，此时会同步部分好友信息
 */
  Future<User> userInfo(String userId) {
    return _methodChannel
        .invokeMethod('userInfo', {"userId": userId})
        .then((o) => Result.parse(o))
        .then((o) => o.unbox((payload) => User.parse(payload)));
  }

  /**
 *  从云信服务器批量获取用户资料
 *
 *  @param users       用户id列表
 *  @param completion  用户信息回调
 *
 *  @discussion 需要将用户信息交给云信托管，此接口才有效。调用此接口，不会触发 - (void)onUserInfoChanged: 回调。
 *              该接口会将获取到的用户信息缓存在本地，所以需要避免此接口的滥调，导致存储过多无用数据到本地而撑爆缓存:如在聊天室请求请求每个聊天室用户数据将造成缓存过大而影响程序性能
 *              本接口一次最多支持 150 个用户信息获取
 *  此接口可以批量从服务器获取用户资料，出于用户体验和流量成本考虑，不建议应用频繁调用此接口。对于用户数据实时性要求不高的页面，应尽量调用读取本地缓存接口。
 */
  Future<List<User>> fetchUserInfos(List<String> userIds) {
    return _methodChannel
        .invokeMethod('fetchUserInfos', {"userIds": userIds})
        .then((o) => Result.parse(o))
        .then((o) => o.unbox((payload) => User.parseList(payload)));
  }

/**
 *  修改自己的用户资料
 *
 *  @param values      需要更新的用户信息键值对
 *  @param completion  修改结果回调
 *
 *  @discussion   这个接口可以一次性修改多个属性,如昵称,头像等,传入的数据键值对是 {@(NIMUserInfoUpdateTag) : NSString},
 *                无效数据将被过滤。一些字段有修改限制，具体请参看 NIMUserInfoUpdateTag 的相关说明
 */
  Future<void> updateMyUserInfo() {}

  void listen(EventListener listener) {
    this._eventListener = listener;
  }
}
