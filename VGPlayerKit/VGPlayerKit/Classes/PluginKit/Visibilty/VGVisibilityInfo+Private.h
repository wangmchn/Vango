//
//  VGVisibilityInfo+Private.h
//  VGPlayerKit
//
//  Created by markmwang on 2021/11/29.
//

#import "VGVisibilityInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface VGVisibilityInfo ()
/// 当前是否在视图树上，当页面不可见/从视图移除时，该值会变成 NO
@property (nonatomic, assign, readwrite) BOOL isOnViewTree;
/// 当前 App 是否在活跃状态
@property (nonatomic, assign, readwrite) BOOL isAppActive;
/// 当前播放器是否处于可见状态
/// @discussion 即播放器在视图树上且 APP 处于前台 (isOnViewTree && isAppActive)
@property (nonatomic, assign, readwrite) BOOL isVisible;

@end

NS_ASSUME_NONNULL_END
