//
//  Result.swift
//  nim
//
//  Created by rawlings on 2021/4/26.
//

import Foundation
import EVReflection
import NIMSDK

public class Result: NSObject, EVReflectable {
    var success: Bool
    var payload: String
    
    init(_ isSuccessed: Bool, _ payload: String) {
        // 试了下, 发现 Bool 可以直接转换成功
        // self.success = NSNumber(value: isSuccess)
        self.success = isSuccessed
        self.payload = payload
    }
    
    static func successed(_ message: String) -> Result {
        return Result(true, message)
    }
    
    static func failed(_ message: String) -> Result {
        return Result(false, message)
    }
    
    static func payload(_ payload: EVReflectable) -> Result {
        return Result(true, payload.toJsonString())
    }
    
    static func error(_ error: Error) -> Result {
        if let error = error as? NimError {
            return Result(false, error.msg)
        } else {
            return Result(false, error.localizedDescription)
        }
    }
}

extension Result {
    
    static func payload(_ payload: [NIMRecentSession]) -> Result {
        return Result(true, payload.map { RecentSession.reproduce(from: $0) }.toJsonString())
    }
    
//    static func payload(_ payload: [RecentSession]) -> Result {
//        return Result(true, payload.toJsonString())
//    }
    
    static func payload(_ payload: [User]) -> Result {
        return Result(true, payload.toJsonString())
    }
    
    static func payload(_ payload: [NIMMessage]) -> Result {
        return Result(true, payload.map { Message.reproduce(from: $0) }.toJsonString())
    }
}
