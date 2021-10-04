//
//  VGPlugin.m
//  Vango
//
//  Created by markmwang on 2021/9/18.
//

#import "VGPlugin.h"

@implementation VGPlugin

- (instancetype)initWithSender:(VGSender *)sender {
    self = [super init];
    if (self) {
        _sender = sender;
    }
    return self;
}

- (void)updateDataSource:(id)dataSource {
    _dataSource = dataSource;
}

@end
