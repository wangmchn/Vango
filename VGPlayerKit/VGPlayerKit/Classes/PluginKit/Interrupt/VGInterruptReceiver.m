//
//  VGInterruptReceiver.m
//  VGPlayerKit
//
//  Created by markmwang on 2021/12/14.
//

#import "VGInterruptReceiver.h"
#import <CallKit/CallKit.h>
#import <Vango/VGCoreEvents.h>
#import "VGVisibilityInfo.h"

typedef NS_ENUM(NSUInteger, VGInterruptType) {
    VGInterruptTypeCall,
    VGInterruptTypeVisibility,
    VGInterruptTypeUserInteract,
};

@interface VGInterruptReceiver () <VGCoreEvents, CXCallObserverDelegate>
@property (nonatomic, strong) CXCallObserver *callObserver;
@end

@implementation VGInterruptReceiver

- (void)bindPlugin:(id)plugin {
    [super bindPlugin:plugin];
    [self setUpReacts];
}

#pragma mark - Private
- (void)setUpReacts {
    VGReceiverObserve(VGVisibilityInfo, @"isVisibile", {
        if (object.isVisible) {
            [receiver.plugin resume:VGInterruptTypeVisibility];
        } else {
            [receiver.plugin interrupt:VGInterruptTypeVisibility];
        }
    });
}

- (void)callDidChange {
    if (self.callObserver.calls.count > 0) {
        [self.plugin interrupt:VGInterruptTypeCall];
    } else {
        [self.plugin resume:VGInterruptTypeCall];
    }
}

#pragma mark - Events
- (void)coreDidInject {
    [self.callObserver setDelegate:self queue:nil];
    [self callDidChange];
}

- (void)coreDidRemove {
    [self.callObserver setDelegate:nil queue:nil];
}

#pragma mark - CXCallObserverDelegate
- (void)callObserver:(CXCallObserver *)callObserver callChanged:(CXCall *)call {
    [self callDidChange];
}

#pragma mark - Getter
- (CXCallObserver *)callObserver {
    if (!_callObserver) {
        _callObserver = [[CXCallObserver alloc] init];
    }
    return _callObserver;
}

@end
