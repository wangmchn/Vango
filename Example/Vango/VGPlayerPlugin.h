//
//  VGPlayerPlugin.h
//  Vango_Example
//
//  Created by markmwang on 2021/10/4.
//  Copyright © 2021 wangmchn@163.com. All rights reserved.
//

#import <Vango/VGCorePlugin.h>
#import <AVFoundation/AVFoundation.h>
#import "VGVideoInfo.h"
#import "VGPlayerEvents.h"

NS_ASSUME_NONNULL_BEGIN

@interface VGPlayerPlugin : VGCorePlugin <id<VGVideoInfo>, VGSender<VGPlayerEvents> *, VGLayout *, AVPlayer *>

@end

NS_ASSUME_NONNULL_END
