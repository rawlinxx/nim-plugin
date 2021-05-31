//
//  Method.swift
//  nim
//
//  Created by rawlings on 2021/4/21.
//

import Foundation

public enum Method: String {
    case register
    case login
    case logout
    // recent session
    case allRecentSessions
    // messages
    case messagesInSession
    case messagesInSessionByIds
    case deleteMessage
    case deleteAllMessagesInSession
    // send msg
    case sendTextMessage
    case sendTipMessage
    case sendImageMessage
    case sendAudioMessage
    case sendVideoMessage
    case sendFileMessage
    case sendLocationMessage
    case sendCustomMessage
    // mark read
    case markAllMessagesReadInSession
    case batchMarkMessagesRead
    case markAllMessagesRead
    // user
    case userInfo
    case fetchUserInfos
}

public extension Method {
    
    
}

