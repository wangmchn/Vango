//
//  VGConfiguration.h
//  Vango
//
//  Created by markmwang on 2021/10/2.
//

#import <Foundation/Foundation.h>
#import "VGPlugin.h"

NS_ASSUME_NONNULL_BEGIN

@interface VGConfiguration : NSObject
/// 核心插件，用于处理核心模块，维护核心模块的逻辑，返回的 Class 必须是 VGCorePlugin 子类
@property (nonatomic, readonly) Class corePluginClass;
/// 插件的配置，返回的 Class 必须是 VGPlugin 的子类
@property (nonatomic, readonly) NSArray<Class> *pluginClasses;
/// VGLayout 的子类，用于布局组件的各个视图，需要业务定制
@property (nonatomic, readonly) Class layoutClass;
/// 跟组件通信的业务 plugin
/// @discussion 比如页面需要获取组件内部的状态（sharedInfo），或者需要通知事件到内部的各个插件的 receiver，都需要通过这个 plugin 来处理
@property (nonatomic, readonly, nullable) __kindof VGPlugin *bridgePlugin;

@end

NS_ASSUME_NONNULL_END
