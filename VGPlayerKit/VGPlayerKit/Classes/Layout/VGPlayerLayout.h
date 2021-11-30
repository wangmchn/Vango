//
//  VGPlayerLayout.h
//  VGPlayerKit
//
//  Created by markmwang on 2021/11/19.
//

#import <Vango/VGLayout.h>

NS_ASSUME_NONNULL_BEGIN

@interface VGPlayerLayout : VGLayout

- (void)installVideoView:(UIView *)videoView;
- (void)uninstallVideoView:(UIView *)videoView;

@end

NS_ASSUME_NONNULL_END
