//
//  SCXPageManager.m
//  SCXiOS
//
//  Created by wll on 2019/1/22.
//  Copyright © 2019 wll. All rights reserved.
//

#import "SCXPageManager.h"

@implementation SCXPageManager

-(instancetype)init {
    if (self = [super init]) {
        _pageNo = LimitNumStartPage;
        _pageSize = LimitNumPerOnePage;
        _datasArr = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
