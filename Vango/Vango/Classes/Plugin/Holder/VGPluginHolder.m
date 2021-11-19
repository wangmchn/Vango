//
//  VGPluginHolder.m
//  Vango
//
//  Created by markmwang on 2021/10/4.
//

#import "VGPluginHolder.h"
#import "VGSender+Private.h"

@implementation VGPluginHolder {
    VGPlugin *_plugin;
    VGReceiver *_receiver;
    VGSender *_sender;
}

- (instancetype)initWithPlugin:(VGPlugin *)plugin {
    self = [super init];
    if (self) {
        _plugin = plugin;
    }
    return self;
}

- (VGPlugin *)plugin {
    return _plugin;
}

- (void)setSender:(VGSender *)sender {
    _sender = sender;
    _plugin.sender = sender;
}

- (VGSender *)sender {
    return _sender;
}

- (id)sharedInfo {
    return _plugin.sharedInfo;
}

- (__kindof VGReceiver *)receiver {
    return _receiver;
}

- (void)updateReceiver:(__kindof VGReceiver *)receiver {
    if (_receiver) {
        [_sender removeReceiver:_receiver];
        [_receiver bindPlugin:nil];
    }
    _receiver = receiver;
    [_sender addReceiver:receiver];
    [_receiver bindPlugin:_plugin];
}

@end
