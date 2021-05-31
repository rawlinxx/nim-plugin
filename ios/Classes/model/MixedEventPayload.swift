//
//  MixedEventPayload.swift
//  nim
//
//  Created by Rawlings on 5/8/21.
//

import Foundation
import EVReflection
import NIMSDK

@objcMembers
class MixedEventPayload: EVObject, Reproduce {
    
// MARK: - Conversation Event Payload
    var recentSession: RecentSession? = RecentSession()
    var totalUnreadCount: Int?
    
    convenience init(recentSession: NIMRecentSession, totalUnreadCount: Int) {
        self.init()
        self.recentSession = RecentSession.reproduce(from: recentSession)
        self.totalUnreadCount = totalUnreadCount
    }
    
// MARK: - Remote Notification Event Payload
    var nim: String?
    var sessionType: String?
    var sender: String?
    var aps: RemoteNotificationAps?
    
    convenience init(userInfo: [AnyHashable : Any]) {
        self.init()
        self.nim = userInfo["nim"] as? String
        self.sessionType = userInfo["sessionType"] as? String
        self.sender = userInfo["sender"] as? String
        self.aps = RemoteNotificationAps.create(userInfo["aps"])
    }
}



@objcMembers
public class RemoteNotificationAps: EVObject {
    var alert: String
    var badge: Int
    var sound: String

    init(alert: String, badge: Int, sound: String) {
        self.alert = alert
        self.badge = badge
        self.sound = sound
    }
    
    static func create(_ dict: Any?) -> RemoteNotificationAps? {
        if let dict = dict as? [AnyHashable : Any],
           let alert = dict["alert"] as? String,
           let badge = dict["badge"] as? Int,
           let sound = dict["sound"] as? String
        {
            return RemoteNotificationAps(alert: alert, badge: badge, sound: sound)
        }
        return nil
    }

    required init() {
        fatalError("init() has not been implemented")
    }

}
