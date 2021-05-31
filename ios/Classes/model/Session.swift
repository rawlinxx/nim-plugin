//
//  Session.swift
//  nim
//
//  Created by rawlings on 2021/4/23.
//

import Foundation
import NIMSDK
import EVReflection

@objcMembers
public class Session: EVObject, Reproduce {
    
    var sessionId: String = ""

   /**
    *  会话类型,当前仅支持P2P,Team和Chatroom
    */
    var sessionType: NIMSessionType = .P2P
    
    public override func propertyConverters() -> [(key: String, decodeConverter: ((Any?) -> ()), encodeConverter: (() -> Any?))] {
        return [(
            key: "sessionType",
            decodeConverter: { _ in },
            encodeConverter: { () -> String in
                switch self.sessionType {
                case .P2P:
                    return "P2P"
                case .team:
                    return "team"
                case .chatroom:
                    return "chatroom"
                case .YSF:
                    return "YSF"
                case .superTeam:
                    return "superTeam"
                default:
                    return "P2P"
                }}
        )]
    }
}

