//
//  VGReceiver.h
//  Vango
//
//  Created by Mark on 2021/9/25.
//

#import <Foundation/Foundation.h>
#import "VGSharedInfoSet.h"
#import "VGCoreEvents.h"
@class VGPlugin;

NS_ASSUME_NONNULL_BEGIN

/// 便捷的注册观察某个 class 的 keypath 的方法
/// execution 中提供了
/// @param receiver 即当前 recevier 实例
/// @param object 即观察的 class 实例
/// @param change NSDictionary，KVO 变化的信息
/// @example
/// VGReceiverObserve(VGXXXInfo, @"enabled", {
///     if (object.enabled) {
///        // do sth. 例如：
///        [receiver foo];
///     } else {
///        // do sth. 例如：
///        [receiver bar];
///     }
/// });
/// VGReceiverObserve(VGXXXInfo, @"enabled", receiver.plugin.enabled = object.enabled);
#define VGReceiverObserve(cls, keypath, execution) \
self.sharedInfos.react(cls.class).subscribe(keypath, self, ^(id _Nonnull observer, cls * _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) { \
__strong typeof(self) receiver = observer;\
{\
execution;\
}\
});

@interface VGReceiver <__covariant PluginType> : NSObject <VGCoreEvents>
/// The plugin which drive to react from events.
@property (nonatomic, weak, readonly) PluginType plugin;
/// A data center which shared informations from other plugins.
@property (nonatomic, strong, readonly) VGSharedInfoSet *sharedInfos;

/// Bind the plugin, after that, the receiver can driva the plugin to react from events.
/// @param plugin The plugin need to drive.
- (void)bindPlugin:(nullable PluginType)plugin;

/// Initializer
- (instancetype)initWithSharedInfos:(VGSharedInfoSet *)sharedInfos NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
