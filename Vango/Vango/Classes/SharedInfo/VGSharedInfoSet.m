//
//  VGSharedInfoSet.m
//  Vango
//
//  Created by Mark on 2021/9/9.
//

#import "VGSharedInfoSet.h"
#import "VGReactive+Private.h"
#import <pthread/pthread.h>

@implementation VGSharedInfoSet {
    pthread_mutex_t _lock;
    NSMapTable<Class, VGReactive *> *_reactors;
    NSMapTable<Class, id> *_infos;
}
@synthesize react = _react;

- (instancetype)init {
    self = [super init];
    if (self) {
        pthread_mutex_init(&_lock, NULL);
        _reactors = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory|NSPointerFunctionsObjectPointerPersonality valueOptions:NSPointerFunctionsStrongMemory];
        _infos = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory|NSPointerFunctionsObjectPointerPersonality valueOptions:NSPointerFunctionsStrongMemory];
    }
    return self;
}

- (void)dealloc {
    pthread_mutex_destroy(&_lock);
}

#pragma mark - Getter
- (VGReactive * _Nonnull (^)(Class  _Nonnull __unsafe_unretained))react {
    if (!_react) {
        pthread_mutex_lock(&_lock);
        if (!_react) {
            __weak typeof(self) weakSelf = self;
            _react = ^VGReactive *(Class cls) {
                __weak typeof(weakSelf) strongSelf = weakSelf;
                return [strongSelf makeReactive:cls];
            };
        }
        pthread_mutex_unlock(&_lock);
    }
    return _react;
}

#pragma mark - Public
- (void)addObject:(id)object {
    if (!object) {
        NSParameterAssert(object);
        return;
    }
    Class cls = [object class];
    VGReactive *reactive = nil;
    pthread_mutex_lock(&_lock);
    NSParameterAssert([_infos objectForKey:cls] == nil);
    [_infos setObject:object forKey:cls];
    reactive = [_reactors objectForKey:cls];
    pthread_mutex_unlock(&_lock);
    reactive.object = object;
}

- (void)removeObject:(id)object {
    if (!object) {
        NSParameterAssert(object);
        return;
    }
    Class cls = [object class];
    pthread_mutex_lock(&_lock);
    [_infos removeObjectForKey:cls];
    [_reactors removeObjectForKey:cls];
    pthread_mutex_unlock(&_lock);
}

- (id)objectForClass:(Class)cls {
    return [_infos objectForKey:cls];
}

#pragma mark - Private
- (VGReactive *)makeReactive:(Class)cls {
    VGReactive *reactive = nil;
    id info = nil;
    pthread_mutex_lock(&_lock);
    reactive = [_reactors objectForKey:cls];
    info = [_infos objectForKey:cls];
    if (!reactive) {
        reactive = [[VGReactive alloc] initWithClass:cls];
        reactive.object = info;
        [_reactors setObject:reactive forKey:cls];
    }
    pthread_mutex_unlock(&_lock);
    return reactive;
}

@end
