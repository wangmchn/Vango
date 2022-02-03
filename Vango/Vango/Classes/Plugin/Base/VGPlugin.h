//
//  VGPlugin.h
//  Vango
//
//  Created by markmwang on 2021/9/18.
//

#import <Foundation/Foundation.h>
#import "VGSender.h"
#import "VGLayout.h"

NS_ASSUME_NONNULL_BEGIN

typedef id VGNoNeed;
/// A plugin is module which can handle business, and send events if something happens to notify other plugins.
@interface VGPlugin <__covariant SenderType: VGSender *, __covariant LayoutType: VGLayout *> : NSObject
/// The sender is a part of the plugin which can send events.
@property (nonatomic, strong) SenderType sender;
/// The plugin's states / information shared to other plugins.
@property (nonatomic, strong, readonly) id sharedInfo;
/// The layout which manager all plugin views
@property (nonatomic, weak, readonly) LayoutType layout;

/// Initializer
- (instancetype)initWithLayout:(LayoutType)layout NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
