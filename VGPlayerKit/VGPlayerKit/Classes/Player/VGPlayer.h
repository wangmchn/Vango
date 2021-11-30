//
//  VGPlayer.h
//  VGPlayerKit
//
//  Created by markmwang on 2021/11/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol VGPlayerDelegate <NSObject>


@end

@interface VGPlayer : NSObject
/// 总时长
@property (nonatomic, assign, readonly) NSTimeInterval duration;
/// 当前播放时长
@property (nonatomic, assign, readonly) NSTimeInterval playedTime;
/// 缓存的时长
@property (nonatomic, assign, readonly) NSTimeInterval cachedTime;
/// 代理回调
@property (nonatomic, weak) id<VGPlayerDelegate> delegate;
/// 播放器根视图
@property (nonatomic, strong, readonly) UIView *view;

@end

NS_ASSUME_NONNULL_END
