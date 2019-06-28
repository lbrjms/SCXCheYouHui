//
//  CYHNetWorkManager.m
//  SCXiOS
//
//  Created by liuwj on 2019/1/17.
//  Copyright © 2019 wll. All rights reserved.
//

#import "CYHNetWorkManager.h"
#import "NetWorkUrl.h"
#import "NetworkManager.h"
#import "NetworkResponse.h"

@implementation CYHNetWorkManager
/**
 首页数据请求
 */
+ (void)getAppsuccess:(scuccess)success
               failure:(failure)failure
{
    [SCXNetServerTool getRequestWithURL:service_home param:nil success:^(id responseObject, NSInteger statusCode) {
        //
        NetworkResponse *responce = [NetworkResponse yy_modelWithDictionary:responseObject];
        if (responce.success) {
            SCXAppList *model = [SCXAppList yy_modelWithDictionary:responce.result];
            success(model);
        }else{
            failure(responce.message);
        }
    } failure:^(NSError *error, NSInteger statusCode, NSString *errorMsg) {
        //
        failure(errorMsg);
    } showHUD:NO];
}

@end
