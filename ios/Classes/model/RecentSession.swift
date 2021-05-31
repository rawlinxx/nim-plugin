//
//  RecentSession.swift
//  nim
//
//  Created by rawlings on 2021/4/23.
//

import Foundation
import NIMSDK
import EVReflection


@objcMembers
public class RecentSession: EVObject, Reproduce {
    
    
    /**
     *  当前会话
     */
    var session: Session? = Session()

    /**
     *  最后一条消息
     */
    var lastMessage: Message? = Message()

    /**
     *  未读消息数
     */
    var unreadCount: Int = 0

    /**
     *  本地扩展
     */
    var localExt: Dictionary<String, Any> = Dictionary()

    /**
     * 服务端会话的最新更新时间,本地会话无效
     */
    var updateTime: TimeInterval = .zero


    /**
     *  会话服务扩展字段(本地会话该字段无效)
     */
    var serverExt: String = ""

    /**
    *  最后一条消息的类型(本地会话该字段无效)
    */
//    var lastMessageType: NIMLastMsgType

    /**
    *  最后一条撤回通知(本地会话该字段无效)
    *  lastMessageType为NIMLastMsgTypeNormalMessage时，最后一条为普通消息，请使用lastMessage获取，本字段为nil
    *  lastMessageType为NIMLastMsgTypeRevokeNotication时，lastMessage字段为nil，最后一条为撤回通知，请使用本字段获取
    */
//    var lastRevokeNotification: NIMRevokeMessageNotification
    
}
