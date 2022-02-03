//
//  VGPlugin.m
//  Vango
//
//  Created by markmwang on 2021/9/18.
//

#import "VGPlugin.h"

@implementation VGPlugin

- (instancetype)initWithLayout:(VGLayout *)layout {
    self = [super init];
    if (self) {
        _layout = layout;
    }
    return self;
}

@end
