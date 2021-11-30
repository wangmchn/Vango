//
//  VGPlayerInfo.h
//  VGPlayerKit
//
//  Created by markmwang on 2021/11/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VGPlayerInfo : NSObject
/// 总时长
@property (nonatomic, assign, readonly) NSTimeInterval duration;
/// 当前播放时长
@property (nonatomic, assign, readonly) NSTimeInterval playedTime;
/// 缓存的时长
@property (nonatomic, assign, readonly) NSTimeInterval cachedTime;
/// 当前播放器是否在播放
@property (nonatomic, assign, readonly) BOOL playing;
/// 播放器是否已经准备完成
@property (nonatomic, assign, readonly) BOOL prepared;
/// 播放器是否在 loading
@property (nonatomic, assign, readonly) BOOL loading;

@end

NS_ASSUME_NONNULL_END
