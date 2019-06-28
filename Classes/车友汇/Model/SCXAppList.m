//
//  SCXAppList.m
//  SCXiOS
//
//  Created by liuwj on 2019/1/11.
//  Copyright © 2019 wll. All rights reserved.
//

#import "SCXAppList.h"

@implementation SCXAppList
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"userAppsList" : @"SCXAppModel",
             @"appsList":@"SCXAppModel",
             };
}

@end
