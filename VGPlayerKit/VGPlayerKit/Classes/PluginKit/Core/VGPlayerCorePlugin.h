//
//  VGPlayerCorePlugin.h
//  VGPlayerKit
//
//  Created by markmwang on 2021/11/29.
//

#import <Vango/VGCorePlugin.h>
#import "VGPlayerEvents.h"
#import "VGPlayerLayout.h"
#import "VGPlayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface VGPlayerCorePlugin : VGCorePlugin <VGNoNeed, VGSender<VGPlayerEvents> *, VGPlayerLayout *, VGPlayer *>
@property (nonatomic, assign) BOOL interrupt;
@end

NS_ASSUME_NONNULL_END
