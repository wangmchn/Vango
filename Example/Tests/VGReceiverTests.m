//
//  VGReceiverTests.m
//  Vango_Tests
//
//  Created by markmwang on 2021/12/14.
//  Copyright © 2021 wangmchn@163.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Vango/VGSharedInfoSet.h>
#import <Vango/VGReceiver.h>
#import <Vango/VGPlugin.h>
#import "VGTestObj.h"

@interface VGTestPlugin : VGPlugin
@property (nonatomic, assign) NSString *name;
@end

@implementation VGTestPlugin


@end

@interface VGTestReceiver : VGReceiver <VGTestPlugin *>

@end

@implementation VGTestReceiver

- (void)bindPlugin:(id)plugin {
    [super bindPlugin:plugin];
    [self setUpReacts];
}

- (void)setUpReacts {
    VGReceiverObserve(VGTestObj, @"name", {
        receiver.plugin.name = object.name;
    });
}

@end

@interface VGReceiverTests : XCTestCase

@end

@implementation VGReceiverTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testVGReaceiverObserve {
    VGSharedInfoSet *sharedInfoSet = [[VGSharedInfoSet alloc] init];
    VGTestObj *obj = [[VGTestObj alloc] init];
    [sharedInfoSet addObject:obj];
    VGTestPlugin *plugin = [[VGTestPlugin alloc] initWithLayout:[VGLayout new]];
    VGTestReceiver *receiver = [[VGTestReceiver alloc] initWithSharedInfos:sharedInfoSet];
    [receiver bindPlugin:plugin];
    obj.name = @"abc";
    XCTAssert([plugin.name isEqualToString:@"abc"]);
}

@end
