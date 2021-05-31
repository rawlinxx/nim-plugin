//
//  NimError.swift
//  nim
//
//  Created by rawlings on 2021/4/27.
//

import Foundation

public struct NimError: Error {
    public let msg: String
    init(_ msg: String) {
        self.msg = msg
    }
}
