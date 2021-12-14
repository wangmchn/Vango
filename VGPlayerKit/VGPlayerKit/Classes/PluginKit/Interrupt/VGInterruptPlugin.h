//
//  VGInterruptPlugin.h
//  VGPlayerKit
//
//  Created by markmwang on 2021/12/14.
//

#import <Vango/VGPlugin.h>

NS_ASSUME_NONNULL_BEGIN

@interface VGInterruptPlugin : VGPlugin

- (void)interrupt:(NSUInteger)type;

- (void)resume:(NSUInteger)type;

@end

NS_ASSUME_NONNULL_END
