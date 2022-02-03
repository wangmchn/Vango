//
//  VGLayout.h
//  Vango
//
//  Created by markmwang on 2021/9/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VGLayout <__covariant VGUIComponent: UIView *> : NSObject
/// 根视图，所有 plugin 的 UIComponent 都基于该视图布局
@property (nonatomic, strong, readonly) UIView *rootView;
/// 装载 UIComponent
- (void)install:(VGUIComponent)component;
/// 卸载 UIComponent
- (void)uninstall:(VGUIComponent)component;
/// 是否已经 install
- (BOOL)isInstalled:(VGUIComponent)component;
/// 布局子视图
- (void)layoutSubviews;

@end

NS_ASSUME_NONNULL_END
