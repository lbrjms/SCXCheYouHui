//
//  NetworkResponse.m
//  SCXiOS
//
//  Created by liuwj on 2019/1/15.
//  Copyright © 2019 wll. All rights reserved.
//

#import "NetworkResponse.h"

@implementation NetworkResponse
- (BOOL)success
{
    return [self.code isEqualToString:@"0"];
}
@end
