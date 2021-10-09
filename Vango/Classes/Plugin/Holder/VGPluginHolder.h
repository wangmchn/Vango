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

@interface VGPluginHolder : NSObject <VGLinkable>

- (instancetype)initWithPlugin:(VGPlugin *)plugin;

- (void)updateReceiver:(__kindof VGReceiver *)receiver;

@end

NS_ASSUME_NONNULL_END
