//
//  VGInterruptPlugin.h
//  VGPlayerKit
//
//  Created by markmwang on 2021/12/14.
//

#import <Vango/VGPlugin.h>

NS_ASSUME_NONNULL_BEGIN
/// 打断插件，决定播放器是否应该应该暂停
@interface VGInterruptPlugin : VGPlugin
/// 某个业务请求打断播放
- (void)interrupt:(NSUInteger)type;
/// 某个业务请求恢复播放
- (void)resume:(NSUInteger)type;
/// 重置，用户点击 or 需要强制播放时调用
- (void)reset;

@end

NS_ASSUME_NONNULL_END
