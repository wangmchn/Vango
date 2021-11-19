//
//  VGCorePlugin.h
//  Vango
//
//  Created by markmwang on 2021/10/3.
//

#import "VGPlugin.h"
#import "VGCoreEvents.h"

NS_ASSUME_NONNULL_BEGIN

@interface VGCorePlugin <__covariant DataSourceType: id, __covariant SenderType: VGSender *, __covariant LayoutType: VGLayout *, __covariant CoreType: id> : VGPlugin <DataSourceType, SenderType, LayoutType>

@property (nonatomic, strong, nullable, readonly) CoreType core;

- (void)inject:(CoreType)core;
- (void)remove:(CoreType)core;

@end

NS_ASSUME_NONNULL_END
