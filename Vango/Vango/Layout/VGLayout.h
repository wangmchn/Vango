//
//  VGLayout.h
//  Vango
//
//  Created by markmwang on 2021/9/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VGLayout <__covariant VGUIComponent: UIView *> : NSObject
@property (nonatomic, strong, readonly) UIView *rootView;

- (void)install:(VGUIComponent)component;
- (void)uninstall:(VGUIComponent)component;

- (instancetype)initWithRootView:(UIView *)rootView NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
