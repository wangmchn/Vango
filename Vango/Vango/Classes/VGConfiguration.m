//
//  VGConfiguration.m
//  Vango
//
//  Created by markmwang on 2021/10/2.
//

#import "VGConfiguration.h"
#import "VGPlugin.h"
#import "VGReceiver.h"

@implementation VGPluginPair

- (instancetype)initWithPluginClass:(Class)pluginClass
                      receiverClass:(Class)receiverClass {
    NSParameterAssert([pluginClass isKindOfClass:[VGPlugin class]]);
    NSParameterAssert([pluginClass isKindOfClass:[VGReceiver class]]);
    self = [super init];
    if (self) {
        _pluginClass = pluginClass;
        _receiverClass = receiverClass;
    }
    return self;
}

+ (instancetype)pairWithPluginClass:(Class)pluginClass receiverClass:(Class)receiverClass {
    return [[self alloc] initWithPluginClass:pluginClass receiverClass:receiverClass];
}

@end

@implementation VGConfiguration

@end
