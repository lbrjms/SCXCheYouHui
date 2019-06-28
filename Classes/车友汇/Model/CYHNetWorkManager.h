//
//  CYHNetWorkManager.h
//  SCXiOS
//
//  Created by liuwj on 2019/1/17.
//  Copyright © 2019 wll. All rights reserved.
//

#import "BaseObject.h"
#import "SCXAppList.h"
#import "SCXNetServerTool.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^scuccess)(id response);
typedef void(^failure)(NSString *errorMessage);


@interface CYHNetWorkManager : BaseObject
/**
 车友汇数据请求
 */
+ (void)getAppsuccess:(scuccess)success
               failure:(failure)failure;

@end

NS_ASSUME_NONNULL_END
