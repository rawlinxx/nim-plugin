import Flutter
import UIKit
import EVReflection
import NIMSDK

public typealias JsonResult = (Any?) -> Void

public class SwiftNimPlugin: NSObject, FlutterPlugin {
    
    let handler: Handler = Handler.instance
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let method_channel = FlutterMethodChannel(name: "nim_method", binaryMessenger: registrar.messenger())
        let event_channel = FlutterEventChannel(name: "nim_event", binaryMessenger: registrar.messenger())
        let instance = SwiftNimPlugin()
        registrar.addMethodCallDelegate(instance, channel: method_channel)
        event_channel.setStreamHandler(instance)
        registrar.addApplicationDelegate(instance)
        
    }
    
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      
        let nonullArgs = call.arguments ?? [String: Any?]()
        guard let method = Method(rawValue: call.method), let args = nonullArgs as? [String: Any?] else {
            assert(true)
            return
        }
        
        let jsonResult: JsonResult = { (_ value: Any?) in
            if let value = value as? EVReflectable {
                result(value.toJsonString())
            } else {
                result(value)
            }
        }
        
        func cast<T>(_ key: String) throws -> T {
            if let v = args[key] as? T {
                return v
            } else {
                throw NimError("参数 [\(key)] 错误")
            }
        }
        
        do {
            switch method {
            case .register:
                handler.register(appKey: try cast("appKey"), apnsCername: try cast("apnsCername"))
                
            case .login:
                handler.login(try cast("account"), try cast("token")) { jsonResult($0) }
                
            case .logout:
                handler.logout { jsonResult($0) }
                
            case .allRecentSessions:
                jsonResult(handler.allRecentSessions())
                
            case .messagesInSession:
//                jsonResult(handler.messagesInSession(sessionId: try cast("sessionId"), sessionType: "P2P", messageId: try cast("messageId"), limit: try cast("limit")))
                jsonResult(handler.messagesInSession(sessionId: try cast("sessionId"), messageId: nil, limit: try cast("limit")))
                
            case .messagesInSessionByIds:
                jsonResult(handler.messagesInSessionByIds(sessionId: try cast("sessionId"), sessionType: try cast("sessionType"), messageIds: try cast("messageIds")))
                
            case .deleteMessage:
                jsonResult(handler.deleteMessage())
            
            case .deleteAllMessagesInSession:
                jsonResult(handler.deleteAllmessagesInSession())
                
            case .sendTextMessage:
                let text: String = try cast("text")
                jsonResult(handler.sendMessage(try cast("sessionId")) { $0.text = text })
                
            case .sendTipMessage:
                let text: String = try cast("text")
                jsonResult(handler.sendMessage(try cast("sessionId")) { $0.text = text; $0.messageObject = NIMTipObject() })
                
            case .sendImageMessage:
                let path: String = try cast("path")
                jsonResult(handler.sendMessage(try cast("sessionId")) { $0.messageObject = NIMImageObject(filepath: path) })
                
            case .sendAudioMessage:
                let path: String = try cast("path")
                jsonResult(handler.sendMessage(try cast("sessionId")) { $0.messageObject = NIMAudioObject(sourcePath: path) })
                
            case .sendVideoMessage:
                let path: String = try cast("path")
                jsonResult(handler.sendMessage(try cast("sessionId")) { $0.messageObject = NIMVideoObject(sourcePath: path) })
                
            case .sendFileMessage:
                let path: String = try cast("path")
                jsonResult(handler.sendMessage(try cast("sessionId")) { $0.messageObject = NIMFileObject(sourcePath: path) })
                
            case .sendLocationMessage:
                let latitude: Double = try cast("latitude")
                let longitude: Double = try cast("longitude")
                let title: String = try cast("title")
                jsonResult(handler.sendMessage(try cast("sessionId")) { $0.messageObject = NIMLocationObject(latitude: latitude, longitude: longitude, title: title) })
                
            case .sendCustomMessage:
                let id: Int = try cast("id")
                let type: String = try cast("type")
                jsonResult(handler.sendMessage(try cast("sessionId")) {
                    let obj = NIMCustomObject()
                    obj.attachment = Attachment(id: id, type: type)
                    $0.messageObject = obj
                })
                
            case .markAllMessagesReadInSession:
                handler.markAllMessagesReadInSession(try cast("sessionId")) { jsonResult($0) }
                
            case .batchMarkMessagesRead:
                handler.batchMarkMessagesRead(try cast("sessionIds")) { jsonResult($0) }
                
            case .markAllMessagesRead:
                handler.markAllMessagesRead()
                
            case .userInfo:
                jsonResult(handler.userInfo(userId: try cast("userId")))
                
            case .fetchUserInfos:
                handler.fetchUserInfos(userIds: try cast("userIds")) { jsonResult($0) }
                
            }
        } catch let error {
            jsonResult(Result.error(error))
        }
    }
}


// MARK: FlutterStreamHandler

extension SwiftNimPlugin: FlutterStreamHandler {
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        handler.sink = events
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        handler.sink = nil
        return nil
    }
}


extension SwiftNimPlugin: UIApplicationDelegate {
    
    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        NIMSDK.shared().updateApnsToken(deviceToken)
    }
    
    public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        let event = Event(type: .didReceiveRemoteNotification, payload: MixedEventPayload(userInfo: userInfo))
        handler.sink?(event.toJsonString())
    }
    
    @available(iOS 10.0, *)
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
    }
    
    @available(iOS 10.0, *)
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
    }
    
}
