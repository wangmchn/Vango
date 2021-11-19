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

- (instancetype)init {
    self = [super init];
    if (self) {
        _rootView = [[UIView alloc] initWithFrame:CGRectZero];
        _rootView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
