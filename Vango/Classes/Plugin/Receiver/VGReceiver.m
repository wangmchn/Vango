//
//  VGReceiver.m
//  Vango
//
//  Created by Mark on 2021/9/25.
//

#import "VGReceiver.h"

@implementation VGReceiver

- (instancetype)initWithSharedInfos:(VGSharedInfoSet *)sharedInfos {
    self = [super init];
    if (self) {
        _sharedInfos = sharedInfos;
    }
    return self;
}

- (void)bindPlugin:(VGPlugin *)plugin {
    _plugin = plugin;
}

@end
