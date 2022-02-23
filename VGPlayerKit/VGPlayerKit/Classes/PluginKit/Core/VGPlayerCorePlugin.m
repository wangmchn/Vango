//
//  VGPlayerCorePlugin.m
//  VGPlayerKit
//
//  Created by markmwang on 2021/11/29.
//

#import "VGPlayerCorePlugin.h"

@interface VGPlayerCorePlugin () <VGPlayerDelegate>

@end

@implementation VGPlayerCorePlugin

- (void)inject:(VGPlayer *)core {
    core.delegate = self;
    [self.layout install:core.view];
    [super inject:core];
    [self interruptChanged];
}

- (void)remove:(VGPlayer *)core {
    core.delegate = nil;
    [self.layout uninstall:core.view];
    [super remove:core];
    [self interruptChanged];
}

- (void)setInterrupt:(BOOL)interrupt {
    _interrupt = interrupt;
    [self interruptChanged];
}

- (void)interruptChanged {
    if (self.interrupt) {
        [self.core pause];
    } else {
        [self.core play];
    }
}

@end
