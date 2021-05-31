import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nim/model/RecentSession.dart';
import 'package:nim/model/enum.dart';
import 'package:nim/nim.dart';
import 'package:permission_handler/permission_handler.dart';

const loginAccount = "13174780873";
const loginToken = "13174780873";
const sessionId = "15905810873";

// const loginAccount = "15905810873";
// const loginToken = "15905810873";
// const sessionId = "13174780873";

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final picker = ImagePicker();
  var currentTitle = "friend";
  var currentContent = "hello !!!";
  var recentSessions = List<RecentSession>();

  @override
  void initState() {
    super.initState();
    setup();
  }

  setup() async {
    if (await Permission.notification.request().isGranted) {}
    // 注册
    Nim()
        .register(
            appKey: "3811db85af6400c09714fc27e8005d43",
            apnsCername: "apns-dev-certificate")
        .whenComplete(() {});

    // 登录
    Nim().login(loginAccount, loginToken).then((result) {
      result.log();
    }).whenComplete(() {
      // 大多数 api 需要登录完成以后才可以使用
    });

    // 事件监听
    Nim().listen((eventType, payload) {
      switch (eventType) {
        case EventType.didAddRecentSession:
          print("didAddRecentSession");
          break;
        case EventType.didUpdateRecentSession:
          print("didUpdateRecentSession");
          setState(() {
            currentTitle = payload.recentSession.lastMessage.senderName;
            currentContent =
                "[${payload.recentSession.lastMessage.messageType}] ${payload.recentSession.lastMessage.text}";
          });
          break;
        case EventType.didRemoveRecentSession:
          print("didRemoveRecentSession");
          break;
        case EventType.didReceiveRemoteNotification:
          print("&&&&&&&&&&&& listenRemoteNotificationEvent");
          pp(payload);
          break;
        default:
          break;
      }
      pp(payload.recentSession);
      print(payload.totalUnreadCount);
    });
  }

  allRecentSessions() {
    Nim().allRecentSessions().then((value) {
      recentSessions = value;
      pp(value);
    }).catchError((err) {
      print(err);
    });
  }

  messagesInSession() {
    Nim()
        .messagesInSession(recentSessions.last.session.sessionId, null, 1000)
        .then((value) {
      pp(value);
      print(value.length);
    }).catchError((err) {
      print(err);
    });
  }

  test() {
    // Nim().userInfo("15905810873").then(pp).catchError(pp);
    // Nim()
    //     .fetchUserInfos(["15905810873", "13174780873", "15557114396"])
    //     .then(pp)
    //     .catchError(pp);
  }

  text() {
    Nim().sendTextMessage(sessionId, "Holo").then((value) => value.log());
  }

  tip() {
    Nim().sendTipMessage(sessionId, "Tip");
  }

  Future image() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    Nim().sendImageMessage(sessionId, pickedFile.path);
  }

  location() {
    Nim()
        .sendLocationMessage(sessionId, 30.27415, 120.15515, "a location")
        .then((value) => value.log());
  }

  custom() {
    Nim().sendCustomMessage(sessionId, 111, "building");
  }

  pp(Object obj) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    print("**************** ${obj} ****************");
    print(encoder.convert(obj));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              AlertDialog(
                title: Text("$currentTitle said:"),
                content: Text(currentContent),
              ),
              FlatButton(
                onPressed: test,
                child: Text("test"),
                color: Colors.blue,
              ),
              FlatButton(
                onPressed: allRecentSessions,
                child: Text("allRecentSessions"),
                color: Colors.blue,
              ),
              FlatButton(
                onPressed: messagesInSession,
                child: Text("messagesInLastSession"),
                color: Colors.blue,
              ),
              FlatButton(
                onPressed: text,
                child: Text("Send Text"),
                color: Colors.blue,
              ),
              FlatButton(
                onPressed: tip,
                child: Text("Send Tip"),
                color: Colors.blue,
              ),
              FlatButton(
                onPressed: image,
                child: Text("Send Image"),
                color: Colors.blue,
              ),
              FlatButton(
                onPressed: location,
                child: Text("Send Location"),
                color: Colors.blue,
              ),
              FlatButton(
                onPressed: custom,
                child: Text("Send Custom"),
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
