//
//  Handler.swift
//  nim
//
//  Created by rawlings on 2021/4/21.
//

import Foundation
import NIMSDK
import ObjectiveC.runtime
import EVReflection


public class Handler: NSObject {

    static let instance = Handler()
    public var sink: FlutterEventSink?
//    var recentSessions: [NIMRecentSession] = []
    
    private override init() {
        super.init()
    }
}

// MARK: - Method Logic
public extension Handler {
    
    func test() {
//        let c = userInfo(userId: "15905810873")
        
    }
    
    func registerPushService() {
        if #available(iOS 11.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { granted, error in
                
            }
        } else {
            // show sad face emoji
        }
    }
    
    func register(appKey: String, apnsCername: String) {
        // 配置额外配置信息（需要在注册 appKey 前完成）
        // 是否需要多端同步未读数
        NIMSDKConfig.shared().shouldSyncUnreadCount = true
        // 自动登录重试次数
        NIMSDKConfig.shared().maxAutoLoginRetryTimes = 10
        //多端登录时，告知其他端，这个端的登录类型。
        NIMSDKConfig.shared().customTag = "\(NIMLoginClientType.typeiOS.rawValue)"
        NIMSDKConfig.shared().animatedImageThumbnailEnabled = true

        let option = NIMSDKOption(appKey: appKey)
        option.apnsCername = apnsCername
        NIMSDK.shared().register(with: option)
        
        NIMSDK.shared().loginManager.add(self)
        NIMSDK.shared().conversationManager.add(self)
    }

    func login(_ account: String, _ token: String, callback: @escaping (Result) -> ()) {
        NIMSDK.shared().loginManager.login(account, token: token) {
            callback($0 == nil ? Result.successed("\(#function)成功") : Result.error($0!))
            self.test()
        }
    }
    
    func logout(callback: @escaping (Result) -> ()) {
        NIMSDK.shared().loginManager.logout {
            callback($0 == nil ? Result.successed("\(#function)成功") : Result.error($0!))
        }
    }
    
    func allRecentSessions() -> Result {
        if let recentSessions = NIMSDK.shared().conversationManager.allRecentSessions() {
            return Result.payload(recentSessions)
        } else {
            return Result.failed("\(#function) 失败")
        }
//            self.recentSessions = recentSessions
//                    // 手动获取最近会话不是频繁操作，可以在云端拉取一次用户信息
//                    let userIds = recentSessions.map({ $0.session!.sessionId})
//                    NIMSDK.shared().userManager.fetchUserInfos(userIds) { [weak self] (users, error) in
//                        guard let `self` = self else {
//                            return
//                        }
//                        self.sendRecentSessionsEvent()
//                    }
//        }
//        return self.recentSessions
    }
    
    func messagesInSession(sessionId: String, sessionType: NIMSessionType = .P2P, messageId: String?, limit: Int) -> Result {
        
//        let anchor = NIMMessage()
//        anchor.messageId = messageId
        if let msgs = NIMSDK.shared().conversationManager.messages(in: NIMSession(sessionId, type: sessionType), message: nil, limit: limit) {
            return Result.payload(msgs)
        } else {
            return Result.failed("\(#function) 失败")
        }
        
    }
    
    func messagesInSessionByIds(sessionId: String, sessionType: NIMSessionType = .P2P, messageIds: [String]) -> Result {
        return Result.failed("还没实现")
    }
    
    func deleteMessage() -> Result {
        return Result.failed("还没实现")
    }
    
    func deleteAllmessagesInSession() -> Result {
        return Result.failed("还没实现")
    }
    

    func sendMessage(_ sessionId: String, _ sessiontype: NIMSessionType = .P2P, messageConfig: (_: inout NIMMessage) -> ()) -> Result {
        var msg = NIMMessage()
        msg.apnsPayload = ["sender": NIMSDK.shared().loginManager.currentAccount(),
                           "sessiontype": sessiontype.rawValue]
        messageConfig(&msg)
        do {
            try NIMSDK.shared().chatManager.send(msg, to: NIMSession(sessionId, type: sessiontype))
            return Result.successed("\(#function)成功")
        } catch {
            return Result.error(error)
        }
    }
    
    func markAllMessagesReadInSession(_ sessionId: String, _ sessiontype: NIMSessionType = .P2P, callback: @escaping (Result) -> ()) {
        NIMSDK.shared().conversationManager.markAllMessagesRead(in: NIMSession(sessionId, type: sessiontype)) {
            callback($0 == nil ? Result.successed("\(#function)成功") : Result.error($0!))
        }
    }
    
    func batchMarkMessagesRead(_ sessionIds: [String], _ sessiontype: NIMSessionType = .P2P, callback: @escaping (Result) -> ()) {
        NIMSDK.shared().conversationManager.batchMarkMessagesRead(in: sessionIds.map{ NIMSession($0, type: sessiontype) }) { (err, _) in
            callback(err == nil ? Result.successed("\(#function)成功") : Result.error(err!))
        }
    }
    
    func markAllMessagesRead() {
        NIMSDK.shared().conversationManager.markAllMessagesRead()
    }
    
    func deleteRecentSession(_ sessionId: String) {
        
    }
    
    
}

// MARK: - User
extension Handler {
    
    func userInfo(userId: String) -> Result {
        if let user = NIMSDK.shared().userManager.userInfo(userId) {
            return Result.payload(User.reproduce(from: user))
        } else {
            return Result.failed("\(#function) 失败")
        }
    }
    
    func fetchUserInfos(userIds: [String], callback: @escaping (Result) -> ()) {
        NIMSDK.shared().userManager.fetchUserInfos(userIds) { (nimUsers, err) in
            if let nimUsers = nimUsers {
                callback(Result.payload(nimUsers.map{ User.reproduce(from: $0) }))
            } else {
                callback(Result.error(err!))
            }
        }
    }
}


extension Handler: NIMLoginManagerDelegate {
    
    
}

extension Handler: NIMConversationManagerDelegate {
    
    public func didAdd(_ recentSession: NIMRecentSession, totalUnreadCount: Int) {
        let payload = MixedEventPayload(recentSession: recentSession, totalUnreadCount: totalUnreadCount)
        let event = Event(type: EventType.didAddRecentSession, payload: payload)
        sink?(event.toJsonString())
    }
    
    public func didUpdate(_ recentSession: NIMRecentSession, totalUnreadCount: Int) {
        let payload = MixedEventPayload(recentSession: recentSession, totalUnreadCount: totalUnreadCount)
        print(RecentSession.reproduce(from: recentSession).toJsonString())
        print(RecentSession.reproduce(from: recentSession).toJsonString(prettyPrinted: true))
        let event = Event(type: EventType.didUpdateRecentSession, payload: payload)
        sink?(event.toJsonString())
    }
    
    public func didRemove(_ recentSession: NIMRecentSession, totalUnreadCount: Int) {
        let payload = MixedEventPayload(recentSession: recentSession, totalUnreadCount: totalUnreadCount)
        let event = Event(type: EventType.didRemoveRecentSession, payload: payload)
        sink?(event.toJsonString())
    }
}

