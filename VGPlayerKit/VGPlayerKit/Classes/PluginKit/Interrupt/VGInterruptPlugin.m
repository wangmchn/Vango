//
//  VGInterruptPlugin.m
//  VGPlayerKit
//
//  Created by markmwang on 2021/12/14.
//

#import "VGInterruptPlugin.h"
#import "VGInterruptInfo+Private.h"

@interface VGInterruptPlugin ()
@property (nonatomic, strong) NSMutableIndexSet *interruptTypes;
@property (nonatomic, strong) VGInterruptInfo *interruptInfo;
@end

@implementation VGInterruptPlugin

- (void)interrupt:(NSUInteger)type {
    [self.interruptTypes addIndex:type];
    [self interruptTypesDidChange];
}

- (void)resume:(NSUInteger)type {
    [self.interruptTypes removeIndex:type];
    [self interruptTypesDidChange];
}

- (void)interruptTypesDidChange {
    if (self.interruptTypes.count > 0) {
        self.interruptInfo.interrupted = YES;
    } else {
        self.interruptInfo.interrupted = NO;
    }
}

#pragma mark - Getter
- (NSMutableIndexSet *)interruptTypes {
    if (!_interruptTypes) {
        _interruptTypes = [[NSMutableIndexSet alloc] init];
    }
    return _interruptTypes;
}

- (VGInterruptInfo *)interruptInfo {
    if (!_interruptInfo) {
        _interruptInfo = [[VGInterruptInfo alloc] init];
    }
    return _interruptInfo;
}

- (id)sharedInfo {
    return self.interruptInfo;
}

@end
