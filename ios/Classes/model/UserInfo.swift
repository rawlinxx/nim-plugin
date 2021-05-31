//
//  UserInfo.swift
//  nim
//
//  Created by rawlings on 2021/4/27.
//

import Foundation
import EVReflection
import NIMSDK

@objcMembers
class UserInfo: EVObject, Reproduce {
    ///  用户昵称
    private(set) var nickName: String?
    ///  用户头像
    private(set) var avatarUrl: String?
    ///  用户头像缩略图
    ///  - Remark: 仅适用于使用云信上传服务进行上传的资源，否则无效。
    private(set) var thumbAvatarUrl: String?
    ///  用户签名
    private(set) var sign: String?
    ///  用户性别
    private(set) var gender: NIMUserGender?
    ///  邮箱
    private(set) var email: String?
    ///  生日
    private(set) var birth: String?
    ///  电话号码
    private(set) var mobile: String?
    ///  用户自定义扩展字段
    private(set) var ext: String?
    
    public override func propertyConverters() -> [(key: String, decodeConverter: ((Any?) -> ()), encodeConverter: (() -> Any?))] {
        return [(
            key: "gender",
            decodeConverter: { _ in },
            encodeConverter: { () -> String in
                switch self.gender {
                case .unknown:
                    return "unknown"
                case .male:
                    return "male"
                case .female:
                    return "female"
                default:
                    return "unknown"
                }}
        )]
    }
}
