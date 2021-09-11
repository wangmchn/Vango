//
//  VGReactive.h
//  Vango
//
//  Created by Mark on 2021/9/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^VGReactiveBlock)(id observer, id object, NSDictionary<NSString *,id> * _Nonnull change);

@interface VGReactive : NSObject

/// 当前响应的数据的 Class 类型
@property (nonatomic, strong, readonly) Class cls;

/// 移除订阅
/// @param keyPath 观察的 keyPath
/// @param observer 观察者
@property (nonatomic, copy, readonly) void (^unsubscribe)(NSString *keyPath, id observer);

/// 添加订阅
/// @param keyPath 订阅观察的 keyPath
/// @param observer 观察者
/// @param block keyPath 数据变化的回调接口
@property (nonatomic, copy, readonly) void (^subscribe)(NSString *keyPath, id observer, VGReactiveBlock block);

/// 构造方法
- (instancetype)initWithClass:(Class)cls NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
