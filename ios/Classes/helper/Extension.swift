//
//  Extension.swift
//  nim
//
//  Created by rawlings on 2021/4/22.
//

import Foundation
import NIMSDK

public protocol Reproduce: NSObject {
    static func reproduce(from source: NSObject) -> Self
}

public extension Reproduce {
    
    static func reproduce(from source: NSObject) -> Self {
        return defaultReproduce(from: source)
    }
    
    /// 子节点不可为空
    static func defaultReproduce(from source: NSObject) -> Self {
        let obj = self.init()
        let fields = getObjcFields(in: type(of: source))
        fields.forEach {
            if obj.responds(to: Selector($0)) {
                let sourceSub = source.value(forKey: $0)
                if let sub = obj.value(forKey: $0) as? Reproduce, let sourceSub = sourceSub as? NSObject {
                    let reproduced = type(of: sub).reproduce(from: sourceSub)
                    obj.setValue(reproduced, forKey: $0)
                } else {
                    obj.setValue(sourceSub, forKey: $0)
                }
            }
        }
        return obj
    }
}

extension Dictionary {
    
    func toJson() -> String {
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: self, options: []) {
            if let jsonText = String(data: jsonData, encoding: .utf8) {
                return jsonText
            }
            return ""
        }
        return ""
    }
}

//public protocol Json {
//    var json: String { get }
//}
//
//extension NIMRecentSession: Json {
//    public var json: String {
//        return RecentSession.reproduce(from: self).toJsonString()
//    }
//}
//
//extension Array: Json where Element: NIMRecentSession {
//    public var json: String {
//        return self.map{ RecentSession.reproduce(from: $0) }.toJsonString()
//    }
//}

//extension Result: Json {
//    public var json: String { self.toJsonString() }
//}
