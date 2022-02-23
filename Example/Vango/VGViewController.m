//
//  VGViewController.m
//  Vango
//
//  Created by wangmchn@163.com on 09/09/2021.
//  Copyright (c) 2021 wangmchn@163.com. All rights reserved.
//

#import "VGViewController.h"
#import <Vango/VGSharedInfoSet.h>
#import "VGTestObj.h"

@class Player;

@protocol TestDelegate <NSObject>

- (void)player:(Player *)player didTimeUpdate:(NSTimeInterval)time duration:(NSTimeInterval)duration;

@end

@interface VGViewController ()
@property (nonatomic, weak) id<TestDelegate> delegate;
@end

@implementation VGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self testHundredObjectsInitialKVOTimeCost];
}

- (void)testHundredObjectsInitialKVOTimeCost {
    NSMutableArray *observers = [NSMutableArray array];
    for (int i = 0; i < 100; i++) {
        [observers addObject:[NSObject new]];
    }
    CFTimeInterval begin = CACurrentMediaTime();
    VGSharedInfoSet *sharedInfoSet = [[VGSharedInfoSet alloc] init];
    VGTestObj *obj = [[VGTestObj alloc] init];
    obj.name = @"1";
    __block NSString *string = nil;
    [observers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        sharedInfoSet.react(VGTestObj.class).subscribe(@"name", obj, ^(id  _Nonnull observer, VGTestObj * _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
            string = object.name.copy;
        });
    }];
    [sharedInfoSet addObject:obj];
    CFTimeInterval diff = CACurrentMediaTime() - begin;
    NSLog(@"cost: %@ms", @(diff * 1000));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
