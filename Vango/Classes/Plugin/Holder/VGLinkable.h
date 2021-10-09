//
//  VGLinkable.h
//  Vango
//
//  Created by markmwang on 2021/10/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol VGLinkable <NSObject>
@optional

@property (nonatomic, strong, readonly, nullable) VGReceiver *receiver;

@property (nonatomic, strong, readonly, nullable) id sharedInfo;

@property (nonatomic, strong, nullable) VGSender *sender;

@end

NS_ASSUME_NONNULL_END
