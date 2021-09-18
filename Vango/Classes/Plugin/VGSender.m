//
//  VGSender.m
//  Vango
//
//  Created by Mark on 2021/9/25.
//

#import "VGSender.h"
#import "VGSender+Private.h"

@interface VGSender ()
@property (nonatomic, strong) NSHashTable<VGReceiver *> *receivers;
@end

@implementation VGSender

- (NSHashTable<VGReceiver *> *)receivers {
    if (!_receivers) {
        _receivers = [NSHashTable weakObjectsHashTable];
    }
    return _receivers;
}

- (void)addReceiver:(VGReceiver *)receiver {
    [self.receivers addObject:receiver];
}

- (void)removeReceiver:(VGReceiver *)receiver {
    [self.receivers removeObject:receiver];
}

@end
