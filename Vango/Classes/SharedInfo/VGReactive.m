//
//  VGReactive.m
//  Vango
//
//  Created by Mark on 2021/9/11.
//

#import "VGReactive.h"
#import "VGReactive+Private.h"
#import <pthread/pthread.h>
#import <objc/runtime.h>
#import <KVOController/KVOController.h>

@implementation VGReactive {
    pthread_mutex_t _lock;
    id _object;
    NSMapTable<id, NSMutableDictionary<NSString *, VGReactiveBlock> *> *_reactors;
}
@synthesize subscribe = _subscribe;
@synthesize unsubscribe = _unsubscribe;

#pragma mark -
- (instancetype)initWithClass:(Class)cls {
    if (self = [super init]) {
        _cls = cls;
        pthread_mutex_init(&_lock, NULL);
    }
    return self;
}

- (void)dealloc {
    [self unobserveAll];
    pthread_mutex_destroy(&_lock);
}

#pragma mark - Public
- (void (^)(NSString * _Nonnull, id _Nonnull, VGReactiveBlock _Nonnull))subscribe {
    if (!_subscribe) {
        pthread_mutex_lock(&_lock);
        if (!_subscribe) {
            __weak typeof(self) weakSelf = self;
            _subscribe = ^(NSString *keyPath, id observer, VGReactiveBlock block) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf addReactorWithKeyPath:keyPath reactor:observer block:block];
            };
        }
        pthread_mutex_unlock(&_lock);
    }
    return _subscribe;
}

- (void (^)(NSString * _Nonnull, id _Nonnull))unsubscribe {
    if (!_unsubscribe) {
        pthread_mutex_lock(&_lock);
        if (!_unsubscribe) {
            __weak typeof(self) weakSelf = self;
            _unsubscribe = ^(NSString *keyPath, id observer) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf removeReactorWithKeyPath:keyPath reactor:observer];
            };
        }
        pthread_mutex_unlock(&_lock);
    }
    return _unsubscribe;
}

- (void)setObject:(id)object {
    pthread_mutex_lock(&_lock);
    if (_object == object) {
        pthread_mutex_unlock(&_lock);
        return;
    }
    _object = object;
    pthread_mutex_unlock(&_lock);
#if DEBUG
    CFTimeInterval beginTime = CACurrentMediaTime();
#endif
    [self startAllReactorsWithObject:object];
#if DEBUG
    CFTimeInterval endTime = CACurrentMediaTime();
    NSLog(@"Time Cost: %lf ms", (endTime - beginTime) * 1000);
#endif
}

#pragma mark - Private
- (void)unobserveAll {
    NSEnumerator *keyEnumerator = nil;
    pthread_mutex_lock(&_lock);
    keyEnumerator = [_reactors keyEnumerator];
    pthread_mutex_unlock(&_lock);
    id reactor = nil;
    while (reactor = [keyEnumerator nextObject]) {
        [[reactor KVOController] unobserve:_object];
    }
}

- (void)startAllReactorsWithObject:(id)object {
    if (!object) {
        return;
    }
    NSMapTable<id, NSDictionary<NSString *, VGReactiveBlock> *> *map = nil;
    pthread_mutex_lock(&_lock);
    if (!_reactors.count) {
        pthread_mutex_unlock(&_lock);
        return;
    }
    map = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory|NSPointerFunctionsObjectPointerPersonality
                                valueOptions:NSPointerFunctionsStrongMemory];
    for (id reactor in _reactors) {
        NSMutableDictionary<NSString *, VGReactiveBlock> *keyPaths = [_reactors objectForKey:reactor];
        [map setObject:keyPaths.copy forKey:reactor];
    }
    _reactors = nil;
    pthread_mutex_unlock(&_lock);
    
    for (id reactor in map) {
        NSDictionary<NSString *, VGReactiveBlock> *keyPaths = [map objectForKey:reactor];
        [keyPaths enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, VGReactiveBlock  _Nonnull obj, BOOL * _Nonnull stop) {
            [self addReactorWithKeyPath:key reactor:reactor block:obj];
        }];
    }
}

- (void)removeReactorWithKeyPath:(NSString *)keyPath reactor:(id)reactor {
    if (!keyPath.length || !reactor) {
        NSParameterAssert(keyPath.length);
        NSParameterAssert(reactor);
        return;
    }
    id object = nil;
    pthread_mutex_lock(&_lock);
    object = _object;
    NSMutableDictionary<NSString *, VGReactiveBlock> *map = [_reactors objectForKey:reactor];
    [map removeObjectForKey:keyPath];
    pthread_mutex_unlock(&_lock);
    if (object) {
        [[reactor KVOController] unobserve:object keyPath:keyPath];
    }
}

- (void)addReactorWithKeyPath:(NSString *)keyPath reactor:(id)reactor block:(VGReactiveBlock)block {
    if (!keyPath.length || !reactor || !block) {
        NSParameterAssert(keyPath.length);
        NSParameterAssert(reactor);
        NSParameterAssert(block);
        return;
    }
    id object = nil;
    pthread_mutex_lock(&_lock);
    object = _object;
    if (!_reactors) {
        _reactors = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory|NSPointerFunctionsObjectPointerPersonality
                                          valueOptions:NSPointerFunctionsStrongMemory];
    }
    NSMutableDictionary<NSString *, VGReactiveBlock> *map = [_reactors objectForKey:reactor];
    if (!map) {
        map = [NSMutableDictionary dictionary];
        [_reactors setObject:map forKey:reactor];
    }
    [map setObject:block forKey:keyPath];
    pthread_mutex_unlock(&_lock);
    if (object) {
        [self startObserve:object reactor:reactor keyPath:keyPath block:block];
    }
}

- (void)startObserve:(id)object reactor:(id)reactor keyPath:(NSString *)keyPath block:(VGReactiveBlock)block {
    if (!object) {
        return;
    }
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial;
    [[reactor KVOController] observe:object keyPath:keyPath options:options block:block];
}

@end
