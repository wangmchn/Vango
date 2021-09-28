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
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSHashTable<VGReceiver *> *> *respondedReceivers;
@property (nonatomic, strong) NSMapTable<VGReceiver *, NSMutableSet<NSString *> *> *selectorsForReceiver;
@end

@implementation VGSender

#pragma mark - Getter
- (NSHashTable<VGReceiver *> *)receivers {
    if (!_receivers) {
        _receivers = [NSHashTable weakObjectsHashTable];
    }
    return _receivers;
}

- (NSMutableDictionary<NSString *,NSHashTable<VGReceiver *> *> *)respondedReceivers {
    if (!_respondedReceivers) {
        _respondedReceivers = [NSMutableDictionary dictionary];
    }
    return _respondedReceivers;
}

- (NSMapTable<VGReceiver *, NSMutableSet<NSString *> *> *)selectorsForReceiver {
    if (!_selectorsForReceiver) {
        _selectorsForReceiver = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsWeakMemory | NSPointerFunctionsObjectPointerPersonality valueOptions:NSPointerFunctionsStrongMemory];
    }
    return _selectorsForReceiver;
}

#pragma mark - Public
- (BOOL)respondsToSelector:(SEL)aSelector {
    NSHashTable<VGReceiver *> *receivers = [self receiversForSelector:aSelector];
    if (receivers.count) {
        return YES;
    }
    return NO;
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol {
    NSArray<VGReceiver *> *allReceivers = self.receivers.allObjects;
    for (VGReceiver *receiver in allReceivers) {
        if ([receiver conformsToProtocol:aProtocol]) {
            return YES;
        }
    }
    return NO;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    NSArray<VGReceiver *> *allResponders = [self receiversForSelector:invocation.selector].allObjects;
    if (allResponders.count) {
        [allResponders enumerateObjectsUsingBlock:^(VGReceiver * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [invocation invokeWithTarget:obj];
        }];
    } else {
        void *nullPointer = NULL;
        [invocation setReturnValue:&nullPointer];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    VGReceiver *receiver = [self receiversForSelector:sel].anyObject;
    if (receiver) {
        return [receiver methodSignatureForSelector:sel];
    }
    return [NSObject methodSignatureForSelector:@selector(init)];
}

#pragma mark - Private
- (NSHashTable<VGReceiver *> *)receiversForSelector:(SEL)sel {
    NSString *seletorKey = NSStringFromSelector(sel);
    NSHashTable<VGReceiver *> *receivers = self.respondedReceivers[seletorKey];
    if (!receivers) {
        receivers = [NSHashTable weakObjectsHashTable];
        NSArray<VGReceiver *> *allReceivers = self.receivers.allObjects;
        for (VGReceiver *receiver in allReceivers) {
            if (![receiver respondsToSelector:sel]) {
                continue;
            }
            [receivers addObject:receiver];
        }
        self.respondedReceivers[seletorKey] = receivers;
    }
    return receivers;
}

- (void)addSelectorToTable:(NSString *)sel forReceiver:(VGReceiver *)receiver {
    NSMutableSet<NSString *> *set = [self.selectorsForReceiver objectForKey:receiver];
    if (!set) {
        set = [NSMutableSet set];
        [self.selectorsForReceiver setObject:set forKey:receiver];
    }
    [set addObject:sel];
}

- (void)addReceiver:(VGReceiver *)receiver {
    [self.receivers addObject:receiver];
    [self.respondedReceivers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSHashTable<VGReceiver *> * _Nonnull obj, BOOL * _Nonnull stop) {
        SEL selecotr = NSSelectorFromString(key);
        if ([receiver respondsToSelector:selecotr]) {
            [obj addObject:receiver];
            [self addSelectorToTable:key forReceiver:receiver];
        }
    }];
}

- (void)removeReceiver:(VGReceiver *)receiver {
    [self.receivers removeObject:receiver];
    NSMutableSet<NSString *> *allSelectors = [self.selectorsForReceiver objectForKey:receiver];
    [allSelectors enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        NSHashTable<VGReceiver *> *receivers = [self.respondedReceivers objectForKey:obj];
        [receivers removeObject:receiver];
    }];
}

@end
