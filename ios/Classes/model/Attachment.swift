//
//  Attachment.swift
//  nim
//
//  Created by rawlings on 2021/4/26.
//

import Foundation
import NIMSDK
import EVReflection

class Attachment: NSObject, NIMCustomAttachment, EVReflectable {
    
    var id: Int
    var type: String
    
    init(id: Int, type: String) {
        self.id = id
        self.type = type
    }
    
    func encode() -> String {
        return self.toJsonString()
    }
    
}
