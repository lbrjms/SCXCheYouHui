//
//  SCXAppModel.m
//  SCXiOS
//
//  Created by liuwj on 2019/1/11.
//  Copyright © 2019 wll. All rights reserved.
//

#import "SCXAppModel.h"

/**
 分类模型
 */
@implementation SCXAppModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"iconUrl":@"icon",
             @"appID":@"id"
             };
}
@end
