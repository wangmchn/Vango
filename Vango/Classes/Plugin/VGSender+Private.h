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

- (void)addReceiver:(VGReceiver *)receiver;

- (void)removeReceiver:(VGReceiver *)receiver;

@end

NS_ASSUME_NONNULL_END
