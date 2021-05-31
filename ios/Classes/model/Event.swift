//
//  Event.swift
//  nim
//
//  Created by Rawlings on 4/27/21.
//

import Foundation
import EVReflection
import NIMSDK

public enum EventType: String {
    case didAddRecentSession
    case didUpdateRecentSession
    case didRemoveRecentSession
    case didReceiveRemoteNotification
}

@objcMembers
public class Event: EVObject {
    
    var type: EventType
    var payload: MixedEventPayload
    
    init(type: EventType, payload: MixedEventPayload) {
        self.type = type
        self.payload = payload
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    public override func propertyConverters() -> [(key: String, decodeConverter: ((Any?) -> ()), encodeConverter: (() -> Any?))] {
        return [(
            key: "type",
            decodeConverter: { _ in },
            encodeConverter: { return self.type.rawValue }
        )]
    }
}
//
//@objcMembers
//public class ConversationManagerDelegatePayload: EVObject {
//    var recentSession: RecentSession
//    var totalUnreadCount: Int
//
//    init(recentSession: NIMRecentSession, totalUnreadCount: Int) {
//        self.recentSession = RecentSession.reproduce(from: recentSession)
//        self.totalUnreadCount = totalUnreadCount
//    }
//
//    required init() {
//        fatalError("init() has not been implemented")
//    }
//
//}
//
//@objcMembers
//public class RemoteNotificationPayload: EVObject {
//    var nim: String
//    var sessiontype: String
//    var sender: String
////    var aps:
//
//
//    init(recentSession: NIMRecentSession, totalUnreadCount: Int) {
//        self.recentSession = RecentSession.reproduce(from: recentSession)
//        self.totalUnreadCount = totalUnreadCount
//    }
//
//    required init() {
//        fatalError("init() has not been implemented")
//    }
//
//}
