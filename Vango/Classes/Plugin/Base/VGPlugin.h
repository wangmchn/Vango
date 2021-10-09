//
//  VGPlugin.h
//  Vango
//
//  Created by markmwang on 2021/9/18.
//

#import <Foundation/Foundation.h>
#import "VGCoreEvents.h"
#import "VGSender.h"

NS_ASSUME_NONNULL_BEGIN

typedef id VGNoNeed;
/// A plugin is module which can handle business, and send events if something happens to notify other plugins.
@interface VGPlugin <__covariant DataSourceType: id, __covariant SenderType: VGSender *> : NSObject <VGCoreEvents>
/// The sender is a part of the plugin which can send events.
@property (nonatomic, strong) SenderType sender;
/// The plugin's states / information shared to other plugins.
@property (nonatomic, strong, readonly) id sharedInfo;
/// The datasource which provider datas the plugin need
@property (nonatomic, weak, readonly) DataSourceType dataSource;

/// Update datasource for this plugin
/// @param dataSource Datasource the plugin needed.
- (void)updateDataSource:(DataSourceType)dataSource;

@end

NS_ASSUME_NONNULL_END
