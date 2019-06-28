//
//  SystemManager.m
//  SCXiOS
//
//  Created by liuwj on 2019/1/19.
//  Copyright © 2019 wll. All rights reserved.
//

#import "SystemManager.h"

@implementation SystemManager
+ (instancetype)sharedInstance {
    static SystemManager * systemManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        systemManager = [SystemManager new];
    });
    return systemManager;
}

@end
