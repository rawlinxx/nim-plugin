//
//  AudioObject.swift
//  nim
//
//  Created by rawlings on 2021/5/7.
//

import Foundation
import EVReflection

@objcMembers
class AudioObject: EVObject, Reproduce {
    ///  语音的本地路径
    private(set) var path: String?
    ///  语音的远程路径
    private(set) var url: String?
    ///  语音时长，毫秒为单位
    ///  - Remark: SDK会根据传入文件信息自动解析出duration,但上层也可以自己设置这个值
    var duration = 0
    ///  音频MD5
    private(set) var md5: String?
}
