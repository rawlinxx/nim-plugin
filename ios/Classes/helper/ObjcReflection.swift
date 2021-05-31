//
//  ObjcReflection.swift
//  nim
//
//  Created by rawlings on 2021/4/23.
//

import Foundation
import ObjectiveC.runtime

public func getObjcFields(in clazz: NSObject.Type) -> [String] {
    var fields = [String]()
    var count = UInt32()
    guard let properties = class_copyPropertyList(clazz, &count) else { return [] }
    for i in 0..<Int(count) {
        let property: objc_property_t = properties[i]
        guard let name = getNameOf(property: property) else { continue }
        fields.append(name)
    }
    free(properties)
    return fields
}

fileprivate func getNameOf(property: objc_property_t) -> String? {
    guard
        let name: NSString = NSString(utf8String: property_getName(property))
    else { return nil }
    return name as String
}
