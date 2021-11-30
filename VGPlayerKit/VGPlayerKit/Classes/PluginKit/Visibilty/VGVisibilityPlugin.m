//
//  VGVisibiltyPlugin.m
//  VGPlayerKit
//
//  Created by markmwang on 2021/11/26.
//

#import "VGVisibilityPlugin.h"
#import "VGVisibilityInfo+Private.h"

@protocol VGVisibilityMonitorDelegate <NSObject>
@required
- (void)viewDidMoveToWindow;

@end

@interface VGVisibilityMonitorView : UIView
@property (nonatomic, weak) id<VGVisibilityMonitorDelegate> delegate;
@end

@implementation VGVisibilityMonitorView

- (void)didMoveToWindow {
    [super didMoveToWindow];
    [self.delegate viewDidMoveToWindow];
}

@end

@interface VGVisibilityPlugin () <VGVisibilityMonitorDelegate>
@property (nonatomic, strong) VGVisibilityInfo *visibilityInfo;
@property (nonatomic, assign) NSInteger sentinel;
@end

@implementation VGVisibilityPlugin

- (instancetype)initWithLayout:(VGPlayerLayout *)layout {
    self = [super initWithLayout:layout];
    if (self) {
        [self setUpMonitor];
    }
    return self;
}

- (VGVisibilityInfo *)visibilityInfo {
    if (!_visibilityInfo) {
        _visibilityInfo = [[VGVisibilityInfo alloc] init];
        _visibilityInfo.isOnViewTree = self.layout.rootView.window;
        _visibilityInfo.isAppActive = [UIApplication sharedApplication].applicationState == UIApplicationStateActive;
    }
    return _visibilityInfo;
}

- (void)setUpMonitor {
    /// 监听 rootview 是否在视图树上
    VGVisibilityMonitorView *monitorView = [[VGVisibilityMonitorView alloc] initWithFrame:CGRectZero];
    monitorView.delegate = self;
    [self.layout.rootView addSubview:monitorView];
    /// 监听 app 是否在前台活跃状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)viewDidMoveToWindow {
    /// 这里之所以要 dispatch_async 是为了过滤以下情况：
    /// [rootView removeFromeSuperView];
    /// [anotherView addSubview:rootView];
    /// 同一个 runloop 内的 remove/add 逻辑会被过滤
    NSInteger sentinel = ++self.sentinel;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (sentinel == self.sentinel) {
            return;
        }
        self.visibilityInfo.isOnViewTree = self.layout.rootView.window;
    });
}

- (void)appResignActive:(NSNotification *)notification {
    self.visibilityInfo.isAppActive = NO;
}

- (void)appBecomeActive:(NSNotification *)notification {
    self.visibilityInfo.isAppActive = YES;
}

#pragma mark - Override
- (id)sharedInfo {
    return self.visibilityInfo;
}

@end
