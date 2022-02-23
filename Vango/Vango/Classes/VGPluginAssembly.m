//
//  VGPluginAssembly.m
//  Vango
//
//  Created by markmwang on 2021/9/18.
//

#import "VGPluginAssembly.h"
#import "VGCorePlugin.h"
#import "VGSharedInfoSet.h"
#import "VGSender+Private.h"

@interface VGPluginAssembly ()
/// sender, 插件的事件通过该模块转发到对应的插件的 receiver 上
@property (nonatomic, strong) VGSender *sender;
/// 布局模块，所有插件的 UIComponent 会被 install 到 layout 上，然后有 layout 决定位置
/// 对于不同的业务，应该有不同的 layout 实现
@property (nonatomic, strong) __kindof VGLayout *layout;
/// 共享数据的中心，各个插件可通过提供 sharedInfo 数据注册到数据中心中，以此可以让其他插件的 receiver 获取自身的状态
/// 比如：一个负责当前视图可见性检测的插件，可以提供 VGVisibleInfo. 来让其他插件监听当前组件的可见性变化
@property (nonatomic, strong) VGSharedInfoSet *sharedInfoSet;
/// 核心插件
@property (nonatomic, strong) VGPluginHolder<VGCorePlugin *> *corePluginHolder;
/// 当前插件集合
@property (nonatomic, strong) NSMutableDictionary<NSString *, VGPluginHolder *> *plugins;

@end

@implementation VGPluginAssembly

- (instancetype)initWithLayout:(__kindof VGLayout *)layout
                 configuration:(VGConfiguration *)configuration {
    self = [super init];
    if (self) {
        _layout = layout;
        _sender = [VGSender alloc];
        _sharedInfoSet = [[VGSharedInfoSet alloc] init];
        _plugins = [NSMutableDictionary dictionary];
        [self setUpWithConfiguration:configuration];
    }
    return self;
}

- (void)setUpWithConfiguration:(VGConfiguration *)configuration {
    _configuration = configuration;
    _corePluginHolder = [self setUpPluginWithPair:configuration.corePair];
    [self linkObject:_corePluginHolder];
    [configuration.pluginPairs enumerateObjectsUsingBlock:^(VGPluginPair * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        VGPluginHolder *holder = [self setUpPluginWithPair:obj];
        [self linkObject:holder];
        [_plugins setObject:holder forKey:NSStringFromClass(obj.pluginClass)];
    }];
}

- (__kindof VGPluginHolder *)setUpPluginWithPair:(VGPluginPair *)pair {
    VGPlugin *plugin = [[pair.pluginClass alloc] init];
    VGReceiver *receiver = [[pair.receiverClass alloc] init];
    [receiver bindPlugin:plugin];
    VGPluginHolder *holder = [[VGPluginHolder alloc] initWithPlugin:plugin];
    return holder;
}

- (void)linkObject:(id<VGLinkable>)obj {
    [obj setSender:_sender];
    [_sharedInfoSet addObject:obj.sharedInfo];
    [_sender addReceiver:obj.receiver];
}

- (void)inject:(id)core {
    [_corePluginHolder.plugin inject:core];
}

- (void)remove:(id)core {
    [_corePluginHolder.plugin remove:core];
}

- (void)setDataSource:(id)dataSource forPlugin:(Class)pluginClass {
    VGPluginHolder *holder = [self.plugins objectForKey:pluginClass];
    [holder.plugin updateDataSource:dataSource];
}

@end
