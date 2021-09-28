//
//  VGReceiver.h
//  Vango
//
//  Created by Mark on 2021/9/25.
//

#import <Foundation/Foundation.h>
#import "VGSharedInfoSet.h"
@class VGPlugin;

NS_ASSUME_NONNULL_BEGIN

@interface VGReceiver <__covariant PluginType: VGPlugin *> : NSObject
/// The plugin which drive to react from events.
@property (nonatomic, weak, readonly) PluginType plugin;
/// A data center which shared informations from other plugins.
@property (nonatomic, strong, readonly) VGSharedInfoSet *sharedInfos;

/// Initializer
- (instancetype)initWithSharedInfos:(VGSharedInfoSet *)sharedInfos NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/// Bind the plugin, after that, the receiver can driva the plugin to react from events.
/// @param plugin The plugin need to drive.
- (void)bindPlugin:(PluginType)plugin;

@end

NS_ASSUME_NONNULL_END
