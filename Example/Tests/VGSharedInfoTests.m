//
//  VGSharedInfoTests.m
//  Vango_Tests
//
//  Created by Mark on 2021/9/9.
//  Copyright © 2021 wangmchn@163.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Vango/VGSharedInfoSet.h>
#import "VGTestObj.h"

@interface VGSharedInfoTests : XCTestCase

@end

@implementation VGSharedInfoTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testSharedInfoSetAddObject {
    VGSharedInfoSet *sharedInfoSet = [[VGSharedInfoSet alloc] init];
    VGTestObj *obj = [[VGTestObj alloc] init];
    // sharedInfoSet 里面 add obj 能正常通过 Class 获取到实例
    [sharedInfoSet addObject:obj];
    XCTAssert(obj == [sharedInfoSet objectForClass:VGTestObj.class]);
    // remove obj 后，该 Class 的实例为 nil
    [sharedInfoSet removeObject:obj];
    XCTAssert([sharedInfoSet objectForClass:VGTestObj.class] == nil);
}

- (void)testSubscribeFirstThenAddObject {
    VGSharedInfoSet *sharedInfoSet = [[VGSharedInfoSet alloc] init];
    __block NSString *string = nil;
    sharedInfoSet.react(VGTestObj.class).subscribe(@"name", self, ^(id  _Nonnull observer, VGTestObj * _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        string = object.name;
    });
    VGTestObj *obj = [[VGTestObj alloc] init];
    obj.name = @"1";
    [sharedInfoSet addObject:obj];
    XCTAssert([string isEqualToString:@"1"]);
    obj.name = @"2";
    XCTAssert([string isEqualToString:@"2"]);
}

- (void)testAddObjectFirstThenSubscribe {
    VGSharedInfoSet *sharedInfoSet = [[VGSharedInfoSet alloc] init];
    VGTestObj *obj = [[VGTestObj alloc] init];
    obj.name = @"1";
    [sharedInfoSet addObject:obj];
    __block NSString *string = nil;
    sharedInfoSet.react(VGTestObj.class).subscribe(@"name", self, ^(id  _Nonnull observer, VGTestObj * _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        string = object.name;
    });
    XCTAssert([string isEqualToString:@"1"]);
    obj.name = @"2";
    XCTAssert([string isEqualToString:@"2"]);
}

- (void)testUnsubscribe {
    VGSharedInfoSet *sharedInfoSet = [[VGSharedInfoSet alloc] init];
    VGTestObj *obj = [[VGTestObj alloc] init];
    obj.name = @"1";
    [sharedInfoSet addObject:obj];
    __block NSString *string = nil;
    sharedInfoSet.react(VGTestObj.class).subscribe(@"name", self, ^(id  _Nonnull observer, VGTestObj * _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        string = object.name;
    });
    XCTAssert([string isEqualToString:@"1"]);
    sharedInfoSet.react(VGTestObj.class).unsubscribe(@"name", self);
    obj.name = @"2";
    XCTAssert(![string isEqualToString:@"2"]);
}

@end
