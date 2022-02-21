//
//  VGPlayerCoreReceiver.m
//  VGPlayerKit
//
//  Created by markmwang on 2021/12/15.
//

#import "VGPlayerCoreReceiver.h"
#import "VGInterruptInfo.h"

@implementation VGPlayerCoreReceiver

- (void)bindPlugin:(id)plugin {
    [super bindPlugin:plugin];
    [self setUpReacts];
}

- (void)setUpReacts {
    VGReceiverObserve(VGInterruptInfo, interrupted, receiver.plugin.interrupt = object.interrupted);
}

@end
