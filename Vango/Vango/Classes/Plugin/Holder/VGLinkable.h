//
//  VGLinkable.h
//  Vango
//
//  Created by markmwang on 2021/10/4.
//

#import <Foundation/Foundation.h>
#import "VGReceiver.h"
#import "VGSender.h"

NS_ASSUME_NONNULL_BEGIN

/// 插件可通过实现 linkable 协议，并注册到 PluginAssembly 中，以此和其他插件进行通信
/// @discussion
/// Linkable 由三部分组成
///
/// 1. Receiver 接收器，插件可通过提供该实例对象来接收其他插件发出的消息，或者获取/监听共享区其他插件共享信息的变化
///
/// 2. SharedInfo 共享信息，插件通过提供该实例来共享当前插件的状态，该对象会被注册到 VGSharedInfoSet 中，其他插件可通过 VGSharedInfoSet 获取对应 class 的实例，或者监听实例属性的变化，详见 VGSharedInfoSet
///
/// 3. Sender 发送器，会在注册到 PluginAssembly 时被设置，可通过直接向 VGSender<YourPluginEvents> *sender 调用的方式转发到其他插件的 Receiver 上，详见 VGSender
///
@protocol VGLinkable <NSObject>
/// 接收器，用于接收由其他插件发出的消息
@property (nonatomic, strong, readonly, nullable) __kindof VGReceiver *receiver;
/// 插件可返回一个实例，用于共享信息给其他插件
/// @warning 任何提供的共享信息应该是一个唯一的 class 类型
@property (nonatomic, strong, readonly, nullable) id sharedInfo;
/// 发送器，各个插件可通过该对象向其他插件发送消息
@property (nonatomic, strong, nullable) __kindof VGSender *sender;

@end

NS_ASSUME_NONNULL_END
