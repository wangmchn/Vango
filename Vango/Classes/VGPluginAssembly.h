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

@interface VGPluginAssembly <__covariant CoreType, __covariant bridgePluginType: VGPluginHolder *> : NSObject

@property (nonatomic, strong, nullable, readonly) CoreType core;

@property (nonatomic, strong, nullable, readonly) bridgePluginType bridgePlugin;

- (void)inject:(CoreType)core;
- (void)remove:(CoreType)core;

- (instancetype)initWithConfiguration:(VGConfiguration *)configuration NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
