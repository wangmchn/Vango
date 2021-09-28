//
//  VGPluginAssembly.h
//  Vango
//
//  Created by markmwang on 2021/9/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VGPluginAssembly <__covariant CoreType> : NSObject

@property (nonatomic, strong, nullable, readonly) CoreType core;

- (void)inject:(CoreType)core;
- (void)remove:(CoreType)core;

@end

NS_ASSUME_NONNULL_END
