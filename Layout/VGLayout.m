//
//  VGLayout.m
//  Vango
//
//  Created by markmwang on 2021/9/27.
//

#import "VGLayout.h"

@implementation VGLayout

- (void)install:(UIView *)view {
    
}

- (void)uninstall:(UIView *)view {
    
}

- (instancetype)initWithRootView:(UIView *)rootView {
    self = [super init];
    if (self) {
        _rootView = rootView;
    }
    return self;
}

@end
