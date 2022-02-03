//
//  VGPlayerLayoutConfiguration.h
//  VGPlayerKit
//
//  Created by markmwang on 2021/12/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, VGPlayerPosition) {
    /// 处于根视图任意位置
    VGPlayerPositionCustom = 0,
    /// 置顶
    VGPlayerPositionTop = 1 << 1,
    /// 置底
    VGPlayerPositionBottom = 1 << 2,
    /// 垂直居中
    VGPlayerPositionVerticalCenter = 1 << 3,
    /// 居左
    VGPlayerPositionLeft = 1 << 4,
    /// 居右
    VGPlayerPositionRight = 1 << 5,
    /// 水平居中
    VGPlayerPositionHorizontalCenter = 1 << 6,
    /// 居中
    VGPlayerPositionCenter = VGPlayerPositionVerticalCenter | VGPlayerPositionHorizontalCenter,
};

struct VGPlayer {
    VGPlayerPosition
};

@protocol VGPlayerLayoutConfiguration <NSObject>

- (VGPlayerPosition)positionForComponent:(UIView<VGPlayerUIComponent> *)component;

@end

NS_ASSUME_NONNULL_END
