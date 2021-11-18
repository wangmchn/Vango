//
//  VGConfiguration.h
//  Vango
//
//  Created by markmwang on 2021/10/2.
//

#import <Foundation/Foundation.h>
#import "VGLinkable.h"
#import "VGLayout.h"

NS_ASSUME_NONNULL_BEGIN

#define VGPairPlugin(pluginCls, receiverCls) [VGPluginPair pairWithPluginClass:pluginCls.class receiverClass:receiverCls.class]

@interface VGPluginPair : NSObject
/// 插件的配置，返回的 Class 必须是 VGPlugin 的子类
@property (nonatomic, strong, readonly) Class pluginClass;
/// 插件的配置，返回的 Class 必须是 VGReceiver 的子类
@property (nonatomic, strong, readonly) Class receiverClass;

- (instancetype)initWithPluginClass:(Class)pluginClass
                      receiverClass:(Class)receiverClass NS_DESIGNATED_INITIALIZER;
+ (instancetype)pairWithPluginClass:(Class)pluginClass
                      receiverClass:(Class)receiverClass;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

@interface VGConfiguration : NSObject
/// 核心插件，用于处理核心模块，维护核心模块的逻辑，返回的 pluginClass 必须是 VGCorePlugin 子类
@property (nonatomic, assign) VGPluginPair *corePair;
/// 插件配置列表
@property (nonatomic, strong) NSArray<VGPluginPair *> *pluginPairs;

@end

NS_ASSUME_NONNULL_END
