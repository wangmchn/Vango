//
//  VGVisibilityInfo.m
//  VGPlayerKit
//
//  Created by markmwang on 2021/11/26.
//

#import "VGVisibilityInfo.h"
#import "VGVisibilityInfo+Private.h"

@implementation VGVisibilityInfo

- (void)setIsAppActive:(BOOL)isAppActive {
    _isAppActive = isAppActive;
    [self updateVisibility];
}

- (void)setIsOnViewTree:(BOOL)isOnViewTree {
    _isOnViewTree = isOnViewTree;
    [self updateVisibility];
}

- (void)updateVisibility {
    BOOL isVisible = self.isAppActive && self.isOnViewTree;
    if (isVisible == self.isVisible) {
        return;
    }
    self.isVisible = isVisible;
}

@end
