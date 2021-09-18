//
//  VGPlugin.m
//  Vango
//
//  Created by markmwang on 2021/9/18.
//

#import "VGPlugin.h"

@implementation VGPlugin

- (instancetype)initWithReceiver:(VGReceiver *)receiver sender:(VGSender *)sender {
    self = [super init];
    if (self) {
        _receiver = receiver;
        _sender = sender;
    }
    return self;
}

- (void)updateDataSource:(id)dataSource {
    _dataSource = dataSource;
}

@end
