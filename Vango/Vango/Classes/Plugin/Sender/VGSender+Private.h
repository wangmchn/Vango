//
//  VGSender+Private.h
//  Vango
//
//  Created by Mark on 2021/9/25.
//

#import "VGSender.h"
#import "VGReceiver.h"

NS_ASSUME_NONNULL_BEGIN

@interface VGSender ()
/// Add receiver to the event center, after that the receiver can receive events send by plugins.
- (void)addReceiver:(VGReceiver *)receiver;
/// Remove receiver from the event center, stop receiving events.
- (void)removeReceiver:(VGReceiver *)receiver;

@end

NS_ASSUME_NONNULL_END
