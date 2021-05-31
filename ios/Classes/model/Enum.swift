//
//  Enum.swift
//  nim
//
//  Created by Rawlings on 4/28/21.
//

enum UserInfoTag: String {
    ///  用户昵称
    case nick
    ///  用户头像
    case avatar
    ///  用户签名
    case sign
    ///  用户性别。请使用指定枚举,如 {@(NIMUserInfoUpdateTagGender) : @(NIMUserGenderMale)}
    case gender
    ///  用户邮箱。请使用合法邮箱
    case email
    ///  用户生日。具体格式为yyyy-MM-dd
    case birth
    ///  用户手机号。请使用合法手机号
    case mobile
    ///  扩展字段
    case ext
    
    var number: Int {
        switch self {
        case .nick:
            return 3
        case .avatar:
            return 4
        case .sign:
            return 5
        case .gender:
            return 6
        case .email:
            return 7
        case .birth:
            return 8
        case .mobile:
            return 9
        case .ext:
            return 10
        }
    }
}
