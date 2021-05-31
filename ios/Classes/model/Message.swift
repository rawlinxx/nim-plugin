//
//  Message.swift
//  nim
//
//  Created by rawlings on 2021/4/25.
//

import Foundation
import NIMSDK
import EVReflection


@objcMembers
public class Message: EVObject, Reproduce {
    
    ///  消息类型
    var messageType: NIMMessageType = .text
    ///  消息子类型.(默认0。设置值需要大于0)
    var messageSubType = 0
    ///  消息来源
    var from: String?
    ///  消息所属会话
    var session: Session? = Session()
    ///  消息ID,唯一标识
    var messageId: String?
    ///  消息服务端ID
    var serverID: String?
    ///  消息文本
    ///  - Remark: 消息中除 NIMMessageTypeText 和 NIMMessageTypeTip 外，其他消息 text 字段都为 nil
    var text: String?
    ///  消息附件内容
    var messageObject: MixedMessageObject? = MixedMessageObject()
    ///  消息设置
    ///  - Remark: 可以通过这个字段制定当前消息的各种设置,如是否需要计入未读，是否需要多端同步等
//    var setting: NIMMessageSetting?
    ///  消息反垃圾配置
//    var antiSpamOption: NIMAntiSpamOption?
    ///  消息推送文案,长度限制500字,撤回消息时该字段无效
    var apnsContent: String?
    ///  消息推送Payload
    ///  - Remark: 可以通过这个字段定义消息推送 Payload ,支持字段参考苹果技术文档,长度限制 2K,撤回消息时该字段无效
    var apnsPayload: [AnyHashable : Any]?
    ///  指定成员推送选项
    ///  - Remark: 通过这个选项进行一些更复杂的推送设定，目前只能在群会话中使用
//    var apnsMemberOption: NIMMessageApnsMemberOption?
    ///  服务器扩展
    ///  - Remark: 客户端可以设置这个字段,这个字段将在本地存储且发送至对端,上层需要保证 NSDictionary 可以转换为 JSON，长度限制 1K
    var remoteExt: [AnyHashable : Any]?
    ///  客户端本地扩展
    ///  - Remark: 客户端可以设置这个字段，这个字段只在本地存储,不会发送至对端,上层需要保证 NSDictionary 可以转换为 JSON
    var localExt: [AnyHashable : Any]?
    ///  消息拓展字段
    ///  - Remark: 服务器下发的消息拓展字段，并不在本地做持久化，目前只有聊天室中的消息才有该字段(NIMMessageChatroomExtension)
    var messageExt: Any?
    ///  消息发送时间
    ///  - Remark: 本地存储消息可以通过修改时间戳来调整其在会话列表中的位置，发完服务器的消息时间戳将被服务器自动修正
    var timestamp: TimeInterval = 0.0
    ///  易盾反垃圾增强反作弊专属字段
    ///  - Remark: 透传易盾反垃圾增强反作弊专属字段
    var yidunAntiCheating: [AnyHashable : Any]?
    ///  环境变量
    ///  - Remark: 环境变量，用于指向不同的抄送、第三方回调等配置
    var env: String?
    ///  消息投递状态 仅针对发送的消息
    var deliveryState: NIMMessageDeliveryState?
    ///  消息附件下载状态 仅针对收到的消息
    var attachmentDownloadState: NIMMessageAttachmentDownloadState?
    ///  是否是收到的消息
    ///  - Remark: 由于有漫游消息的概念,所以自己发出的消息漫游下来后仍旧是"收到的消息",这个字段用于消息出错是时判断需要重发还是重收
    var isReceivedMsg = false
    ///  是否是往外发的消息
    ///  - Remark: 由于能对自己发消息，所以并不是所有来源是自己的消息都是往外发的消息，这个字段用于判断头像排版位置（是左还是右）。
    var isOutgoingMsg = false
    ///  消息是否被播放过
    ///  - Remark: 修改这个属性,后台会自动更新 db 中对应的数据。聊天室消息里，此字段无效。
    var isPlayed = false
    ///  消息是否标记为已删除
    ///  - Remark: 已删除的消息在获取本地消息列表时会被过滤掉，只有根据 messageId 获取消息的接口可能会返回已删除消息。聊天室消息里，此字段无效。
    var isDeleted = false
    ///  对端是否已读
    ///  - Remark: 只有当当前消息为 P2P 消息且 isOutgoingMsg 为 YES 时这个字段才有效，需要对端调用过发送已读回执的接口
    var isRemoteRead = false
    ///  是否已发送群回执
    ///  - Remark: 只针对群消息有效
    var isTeamReceiptSended = false
    ///  群已读回执信息
    ///  - Remark: 只有当当前消息为 Team 消息且 teamReceiptEnabled 为 YES 时才有效，需要对端调用过发送已读回执的接口
//    var teamReceiptInfo: NIMTeamMessageReceipt?
    ///  消息发送者名字
    ///  - Remark: 当发送者是自己时,这个值可能为空,这个值表示的是发送者当前的昵称,而不是发送消息时的昵称。聊天室消息里，此字段无效。
    var senderName: String?
    ///  发送者客户端类型
    var senderClientType: NIMLoginClientType?
    ///  是否在黑名单中
    ///  - Remark: YES 为被目标拉黑;
    var isBlackListed = false
    ///  该消息回复的目标消息的消息ID
    ///  - Remark: 如果未回复其他消息，则为空
    ///  - Remark: A为一条普通消息,B消息为对A回复的消息,则A是B的 replied 消息和 thread 消息; 同时, C为回复B的消息,则C的 replied 消息是B, C的thread消息为A
    var repliedMessageId: String?
    ///  该消息回复的目标消息的服务端ID
    ///  - Remark: 如果未回复其他消息，则为空
    var repliedMessageServerId: String?
    ///  该消息回复的目标消息的发送者
    ///  - Remark: 如果未回复其他消息，则为空
    var repliedMessageFrom: String?
    ///  该消息回复的目标消息的接收者
    ///  - Remark: 如果未回复其他消息，则为空
    var repliedMessageTo: String?
    ///  该消息回复的目标消息的发送时间
    ///  - Remark: 如果未回复其他消息则为0（单位：秒）
    var repliedMessageTime: TimeInterval = 0.0
    ///  该消息的父消息的消息ID
    ///  - Remark: 如果未回复其他消息，则为空
    var threadMessageId: String?
    ///  该消息的父消息的服务端ID
    ///  - Remark: 如果未回复其他消息，则为空
    var threadMessageServerId: String?
    ///  该消息回复的父消息的发送者
    ///  - Remark: 如果未回复其他消息，则为空
    var threadMessageFrom: String?
    ///  该消息回复的目标消息的接收者
    ///  - Remark: 如果未回复其他消息，则为空
    var threadMessageTo: String?
    ///  该消息回复的父消息的发送时间
    ///  - Remark: 如果未回复其他消息则为0（单位：秒）
    var threadMessageTime: TimeInterval = 0.0
    ///  第三方回调回来的自定义扩展字段
    var callbackExt: String?
    ///  消息处理状态
    var status: NIMMessageStatus = .none
    
    
    public override func propertyConverters() -> [(key: String, decodeConverter: ((Any?) -> ()), encodeConverter: (() -> Any?))] {
        return [
            (key: "messageType",
             decodeConverter: { _ in },
             encodeConverter: { () -> String in
                switch self.messageType {
                case .text:
                    return "text"
                case .image:
                    return "image"
                case .audio:
                    return "audio"
                case .file:
                    return "file"
                case .location:
                    return "location"
                case .custom:
                    return "custom"
                case .notification:
                    return "notification"
                case .robot:
                    return "robot"
                case .tip:
                    return "tip"
                case .video:
                    return "video"
                case .rtcCallRecord:
                    return "rtcCallRecord"
                default:
                    return "text"
                }}),
            (key: "status",
             decodeConverter: { _ in },
             encodeConverter: { () -> String in
                switch self.status {
                case .none:
                    return "none"
                case .read:
                    return "read"
                case .deleted:
                    return "deleted"
                default:
                    return "none"
                }}),
            (key: "deliveryState",
             decodeConverter: { _ in },
             encodeConverter: { () -> String in
                switch self.deliveryState {
                case .failed:
                    return "failed"
                case .delivering:
                    return "delivering"
                case .deliveried:
                    return "deliveried"
                default:
                    return "failed"
                }}),
            (key: "attachmentDownloadState",
             decodeConverter: { _ in },
             encodeConverter: { () -> String in
                switch self.attachmentDownloadState {
                case .failed:
                    return "failed"
                case .downloaded:
                    return "downloaded"
                case .downloading:
                    return "downloading"
                case .needDownload:
                    return "needDownload"
                default:
                    return "failed"
                }}),
            (key: "senderClientType",
             decodeConverter: { _ in },
             encodeConverter: { () -> String in
                switch self.senderClientType {
                case .typeUnknown:
                    return "typeUnknown"
                case .typeAOS:
                    return "typeAOS"
                case .typeiOS:
                    return "typeiOS"
                case .typePC:
                    return "typePC"
                case .typeWP:
                    return "typeWP"
                case .typeWeb:
                    return "typeWeb"
                case .typeRestful:
                    return "typeRestful"
                case .typemacOS:
                    return "typemacOS"
                default:
                    return "typeUnknown"
                }}),
            
        ]
    }

}
