//
//  User.swift
//  nim
//
//  Created by rawlings on 2021/4/27.
//

import Foundation
import EVReflection

@objcMembers
class User: EVObject, Reproduce {
    ///  用户Id
    var userId: String?
    ///  备注名，长度限制为128个字符。
    var alias: String?
    ///  扩展字段
    var ext: String?
    ///  服务器扩展字段
    ///  - Remark: 该字段只能由服务器进行修改，客户端只能读取
    ///
    private(set) var serverExt: String?
    ///  用户资料，仅当用户选择托管信息到云信时有效
    ///  用户资料除自己之外，不保证其他用户资料实时更新
    ///  其他用户资料更新的时机为: 1.调用 - (void)fetchUserInfos:completion: 方法刷新用户
    ///                        2.收到此用户发来消息
    ///                        3.程序再次启动，此时会同步好友信息
    private(set) var userInfo: UserInfo? = UserInfo()

//    ///  是否需要消息提醒
//    ///
//    ///  - Returns: 是否需要消息提醒
//    func notifyForNewMsg() -> Bool {
//    }
//
//    ///  是否在黑名单中
//    ///
//    ///  - Returns: 是否在黑名单中
//    func isInMyBlackList() -> Bool {
//    }
}
