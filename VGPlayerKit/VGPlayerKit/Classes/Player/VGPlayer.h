//
//  VGPlayer.h
//  Expecta
//
//  Created by markmwang on 2021/11/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, VGPlayerState) {
    VGPlayerStateIdle,
    VGPlayerStateLoading,
    VGPlayerStatePlaying,
    VGPlayerStatePaused,
    VGPlayerStateError,
};

@interface VGPlayer : NSObject

@property (nonatomic, assign) VGPlayerState state;

@property (nonatomic, assign) NSTimeInterval duration;

@property (nonatomic, assign) NSTimeInterval position;

@end

NS_ASSUME_NONNULL_END
