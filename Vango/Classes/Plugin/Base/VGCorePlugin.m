//
//  VGCorePlugin.m
//  Vango
//
//  Created by markmwang on 2021/10/3.
//

#import "VGCorePlugin.h"

@implementation VGCorePlugin

- (void)inject:(id)core {
    _core = core;
    if ([self.sender respondsToSelector:@selector(coreDidInject)]) {
        [self.sender coreDidInject];
    }
}

- (void)remove:(id)core {
    _core = nil;
    if ([self.sender respondsToSelector:@selector(coreDidRemove)]) {
        [self.sender coreDidRemove];
    }
}

@end
