//
//  SCXPageManager.h
//  SCXiOS
//
//  Created by wll on 2019/1/22.
//  Copyright © 2019 wll. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LimitNumPerOnePage 10
#define LimitNumStartPage  1
/**
 分页管理器
 */
@interface SCXPageManager : NSObject

@property (nonatomic,assign)NSInteger pageNo; //默认为1
@property (nonatomic,assign)NSInteger pageSize; //分页条数默认LimitNumPerOnePage
@property (nonatomic,strong)NSMutableArray * datasArr;

@end
