//
//  VGPluginHolder.h
//  Vango
//
//  Created by markmwang on 2021/10/4.
//

#import <Foundation/Foundation.h>
#import "VGPlugin.h"
#import "VGReceiver.h"
#import "VGLinkable.h"

NS_ASSUME_NONNULL_BEGIN

/// 插件的持有类，没有什么逻辑，只是单纯维护了 plugin/receiver/sender 的关系
@interface VGPluginHolder <__covariant PluginType: VGPlugin *> : NSObject <VGLinkable>
/// 插件
@property (nonatomic, strong, readonly) PluginType plugin;
/// 发送器，各个插件可通过该对象向其他插件发送消息
@property (nonatomic, strong, nullable) __kindof VGSender *sender;
/// 构造方法
- (instancetype)initWithPlugin:(PluginType)plugin;
/// 更新 receiver
- (void)updateReceiver:(__kindof VGReceiver *)receiver;

@end

NS_ASSUME_NONNULL_END
