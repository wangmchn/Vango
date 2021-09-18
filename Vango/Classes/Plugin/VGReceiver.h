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

@property (nonatomic, weak, readonly) PluginType plugin;

@property (nonatomic, strong, readonly) VGSharedInfoSet *sharedInfos;

- (instancetype)initWithSharedInfos:(VGSharedInfoSet *)sharedInfos;

- (void)bindPlugin:(PluginType)plugin;

@end

NS_ASSUME_NONNULL_END
