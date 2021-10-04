//
//  VGCoreEvents.h
//  Vango
//
//  Created by markmwang on 2021/10/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol VGCoreEvents <NSObject>
@optional
- (void)coreDidInject;
- (void)coreDidRemove;
@end

NS_ASSUME_NONNULL_END
