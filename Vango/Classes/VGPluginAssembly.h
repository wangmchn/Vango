//
//  VGPluginAssembly.h
//  Vango
//
//  Created by markmwang on 2021/9/18.
//

#import <Foundation/Foundation.h>
#import "VGConfiguration.h"
#import "VGPluginHolder.h"

NS_ASSUME_NONNULL_BEGIN

@interface VGPluginAssembly <__covariant CoreType> : NSObject
/// 核心模块，整个 Vango 组件由该模块驱动运转，它会最终注册给 VGCorePlugin，由 VGCorePlugin 监听相关事件，并向其他插件抛出事件驱动更新
/// 举个例子，它可以是一个播放器，由 VGCorePlugin 监听抛出暂停/播放/进度更新等事件，由其他插件监听驱动内部逻辑（例如进度条插件会监听进度更新 UI）
@property (nonatomic, strong, nullable, readonly) CoreType core;
/// plugin 配置信息，可通过该对象自定义插件类型
@property (nonatomic, strong, readonly) VGConfiguration *configuration;
/// 插件的根视图
@property (nonatomic, strong, readonly) UIView *view;
/// VGLayout 的子类，用于布局组件的各个视图，需要业务定制
@property (nonatomic, strong, readonly) __kindof VGLayout *layout;
/// 跟组件通信的业务 plugin
/// @discussion 比如页面需要获取组件内部的状态（sharedInfo），或者需要通知事件到内部的各个插件的 receiver，都需要通过这个 plugin 来处理
@property (nonatomic, strong, nullable) id<VGLinkable> bridgePlugin;

/// 注入 core
/// @discussion 业务可通过 inject/remove 方法在两个模块中转移 core
- (void)inject:(CoreType)core;
/// 移除 core
- (void)remove:(CoreType)core;

/// 构造方法
/// @param layout 布局模块，由该模块处理插件内部各个视图布局逻辑
/// @param configuration 插件配置，该模块定义了模块内部的 plugin 以及对应的 receiver
- (instancetype)initWithLayout:(__kindof VGLayout *)layout
                 configuration:(VGConfiguration *)configuration NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
