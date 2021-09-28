//
//  VGLayout.h
//  Vango
//
//  Created by markmwang on 2021/9/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VGLayout : NSObject

- (void)install:(UIView *)view;
- (void)uninstall:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
