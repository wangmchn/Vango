//
//  VGInterruptInfo.h
//  VGPlayerKit
//
//  Created by markmwang on 2021/12/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VGInterruptInfo : NSObject
/// 当前播放是否应该被打断，例如用户接听电话/切换后台等操作时，该值会变化
/// 可通过监听该状态控制播放暂停/恢复播放操作
@property (nonatomic, assign, readonly) BOOL interrupted;

@end

NS_ASSUME_NONNULL_END
