//
//  MixedMessageObject.swift
//  nim
//
//  Created by Rawlings on 5/8/21.
//

import Foundation
import EVReflection
import NIMSDK

@objcMembers
class MixedMessageObject: EVObject, Reproduce {
    
// MARK: - common
    ///  文件显示名
    var displayName: String?
    ///  文件的本地路径
    var path: String?
    ///  文件的远程路径
    var url: String?
    ///  文件名
    var fileName: String?
    ///  文件大小
    var fileLength: Int64 = 0
    ///  文件MD5
    var md5: String?
    
    
// MARK: - video / audio
    ///  视频 / 语音时长，毫秒为单位
    ///  - Remark: SDK会根据传入文件信息自动解析出duration,但上层也可以自己设置这个值
    var duration = 0
    
    ///  视频封面的本地路径
    var coverPath: String?
    ///  视频封面的远程路径
    ///  - Remark: 只有是上传到云信服务器上的视频才支持封面地址，否则地址无效
    var coverUrl: String?
    ///  封面尺寸
    var coverSize = CGSize.zero
    
    
// MARK: - image
    ///  缩略图本地路径
    var thumbPath: String?
    ///  缩略图远程路径
    ///  - Remark: 仅适用于使用云信上传服务进行上传的资源，否则无效。
    var thumbUrl: String?
    ///  图片尺寸
    var size = CGSize.zero
    ///  图片选项
    ///  - Remark: 仅在发送时且通过 initWithImage: 方式初始化才有效
//    var option: NIMImageOption?
    
    
// MARK: - location
    ///  维度
    var latitude = 0.0
    ///  经度
    var longitude = 0.0
    ///  标题
    var title: String?
    
    
// MARK: - tip
    var isTip = false
    
    // overriding reproduce
    static func reproduce(from source: NSObject) -> Self {
        if let _ = source as? NIMTipObject {
            let obj = MixedMessageObject()
            obj.isTip = true
            return obj as! Self
        } else {
            return defaultReproduce(from: source)
        }
    }
}
