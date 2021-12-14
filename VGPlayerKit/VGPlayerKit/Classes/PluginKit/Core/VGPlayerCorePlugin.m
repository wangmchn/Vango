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
    [self.layout installVideoView:core.view];
    [super inject:core];
}

- (void)remove:(VGPlayer *)core {
    core.delegate = nil;
    [self.layout uninstallVideoView:core.view];
    [super remove:core];
}

@end
