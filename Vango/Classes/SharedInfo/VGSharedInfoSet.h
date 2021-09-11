//
//  VGSharedInfoSet.h
//  Vango
//
//  Created by Mark on 2021/9/9.
//

#import <Foundation/Foundation.h>
#import "VGReactive.h"

NS_ASSUME_NONNULL_BEGIN

#define VGSharedInfo(cls, name, set) cls *name = [set objectForClass:cls.class]

/// VGSharedInfoSet 用来共享数据的数据集合，线程安全，所有注册在该实例用于共享的数据 class 必须各不相同
/// 可通过 react.subscribe 来订阅内部数据 KeyPath 改变
@interface VGSharedInfoSet : NSObject

/// 获取 Class 对应的 VGReactive，可通过 VGReactive 订阅该 Class 实例中的 keyPath 变化
/// @discussion 如订阅时 Class 对应的实例还未被注册到共享区，那么会在注册的第一时间添加观察并发出事件
@property (nonatomic, copy) VGReactive *(^react)(Class cls);

/// 添加一个实例到共享区
/// @discussion 注意，每个被添加到共享区的实例 Class 类型必须唯一
/// @param object 共享的实例数据
- (void)addObject:(id)object;

/// 将一个实例从共享区移除
/// @param object 移除共享的实例数据
- (void)removeObject:(id)object;

/// 获取 Class 对应的共享数据，如还未注册，则为空
/// @param cls 共享数据的 Class 类型
- (nullable id)objectForClass:(Class)cls;

@end

NS_ASSUME_NONNULL_END
