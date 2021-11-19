//
//  VGPluginAssembly.m
//  Vango
//
//  Created by markmwang on 2021/9/18.
//

#import "VGPluginAssembly.h"
#import "VGCorePlugin.h"
#import "VGSharedInfoSet.h"
#import "VGSender+Private.h"

@implementation VGPluginAssembly {
    VGSender *_sender;
    VGLayout *_layout;
    VGSharedInfoSet *_sharedInfoSet;
    VGPluginHolder<VGCorePlugin *> *_corePluginHolder;
    NSMutableArray<id<VGLinkable>> *_pluginList;
}

- (instancetype)initWithLayout:(__kindof VGLayout *)layout
                 configuration:(VGConfiguration *)configuration {
    self = [super init];
    if (self) {
        _layout = layout;
        _sender = [VGSender alloc];
        _sharedInfoSet = [[VGSharedInfoSet alloc] init];
        _pluginList = [NSMutableArray array];
        [self setUpWithConfiguration:configuration];
    }
    return self;
}

- (void)setUpWithConfiguration:(VGConfiguration *)configuration {
    _configuration = configuration;
    _corePluginHolder = [self setUpPluginWithPair:configuration.corePair];
    [self linkObject:_corePluginHolder];
    [configuration.pluginPairs enumerateObjectsUsingBlock:^(VGPluginPair * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        VGPluginHolder *holder = [self setUpPluginWithPair:obj];
        [self linkObject:holder];
        [_pluginList addObject:holder];
    }];
}

- (__kindof VGPluginHolder *)setUpPluginWithPair:(VGPluginPair *)pair {
    VGPlugin *plugin = [[pair.pluginClass alloc] init];
    VGReceiver *receiver = [[pair.receiverClass alloc] init];
    [receiver bindPlugin:plugin];
    VGPluginHolder *holder = [[VGPluginHolder alloc] initWithPlugin:plugin];
    return holder;
}

- (void)linkObject:(id<VGLinkable>)obj {
    [obj setSender:_sender];
    [_sharedInfoSet addObject:obj.sharedInfo];
    [_sender addReceiver:obj.receiver];
}

- (void)inject:(id)core {
    [_corePluginHolder.plugin inject:core];
}

- (void)remove:(id)core {
    [_corePluginHolder.plugin remove:core];
}

@end
