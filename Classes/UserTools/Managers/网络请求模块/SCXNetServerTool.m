//
//  SCXNetServerTool.m
//  SCXiOS
//
//  Created by wll on 2019/1/15.
//  Copyright © 2019 wll. All rights reserved.
//

#import "SCXNetServerTool.h"
#import <AFNetworking.h>
#import "sys/utsname.h"
#import "UIView+Additions.h"

@implementation SCXNetServerTool

/**
 get请求
 */
+ (NSURLSessionTask *)getRequestWithURL:(NSString *)urlString param:(NSDictionary *)params success:(successHandler)successBlk failure:(failHandler)failureBlk showHUD:(BOOL)yn {
    return [self requestWithURL:urlString method:@"get" param:params imageArray:nil success:successBlk failure:failureBlk showHUD:yn];
}
/**
 post请求
 */
+ (NSURLSessionTask *)postRequestWithURL:(NSString *)urlString params:(NSArray *)params success:(successHandler)successBlk failure:(failHandler)failureBlk showHUD:(BOOL)yn {
    
    return [self requestWithURL:urlString method:@"post" param:params imageArray:nil success:successBlk failure:failureBlk showHUD:yn];
}

/**
 post请求
 */
+ (NSURLSessionTask *)postRequestWithURL:(NSString *)urlString param:(NSDictionary *)params success:(successHandler)successBlk failure:(failHandler)failureBlk showHUD:(BOOL)yn {
    
    return [self requestWithURL:urlString method:@"post" param:params imageArray:nil success:successBlk failure:failureBlk showHUD:yn];
}
/**
 图片上传
 */
+ (NSURLSessionTask *)uploadImageWithArray:(NSArray <UIImage *>*)imageArray url:(NSString *)urlString param:(NSDictionary *)param success:(successHandler)successBlk failure:(failHandler)failureBlk showHUD:(BOOL)yn {
    
    return [self requestWithURL:urlString method:@"post" param:param imageArray:imageArray success:successBlk failure:failureBlk showHUD:yn];
}


/** 基请求 */
+ (NSURLSessionTask *)requestWithURL:(NSString *)urlString method:(NSString *)METHOD param:(id)params imageArray:(NSArray <UIImage *>*)imageArray success:(successHandler)successBlk failure:(failHandler)failureBlk showHUD:(BOOL)yn {
    if (yn) {
        [[UIApplication sharedApplication].keyWindow jcw_showGifLoading];
    }
    
    NSURLSessionTask * task = nil;

    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        !failureBlk?:failureBlk(nil,-200,@"请检查您的网络");
        return task;
    }
//    [WLFileManager saveUserData:content forKey:@"IPHOST"];

    NSString *host = [WLFileManager readUserDataForKey:@"IPHOST"];
    if (![urlString hasPrefix:@"http"]) {
        if (!host) {
            urlString = [[NSString stringWithFormat:@"%@/%@",kSCXBaseUrl,urlString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
        }else{
            urlString = [[NSString stringWithFormat:@"%@/%@",host,urlString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
    }
   
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [SCXNetServerTool ptDefaultSerializer];

    void(^af_success_cb)(NSHTTPURLResponse *response, id responseObject) = ^(NSHTTPURLResponse *response, id responseObject) {
        ///响应头中
        NSString * token = response.allHeaderFields[kSCXToken];
        if (token.length) {
            [WLFileManager saveUserData:token forKey:kSCXToken];
        }
        !successBlk?:successBlk(responseObject,response.statusCode);
        if (yn) {
            [[UIApplication sharedApplication].keyWindow hideHUDLoading:0.2];
        }
    };
    void(^af_error_cb)(NSHTTPURLResponse *response, NSError *error) = ^(NSHTTPURLResponse *response, NSError *error) {
        NSString *strErrorMsg;
        ///防止重复提交 保存token值  之后传递出去唯一性 非空  因为提现可能出现多次
        NSString * token = response.allHeaderFields[kSCXToken];
        if (token.length) {
            [WLFileManager saveUserData:token forKey:kSCXToken];
        }
        if (response.statusCode == 401) {
            
            strErrorMsg = @"登录失效,请重新登录";
            
//            [SCXUserInfoManager clearUserInfo];
//            [SCXUserInfoManager showLogInVC];
        }
        
        !failureBlk?:failureBlk(error,response.statusCode?:error.code,strErrorMsg?:[NSString stringWithFormat:@"服务器开小差啦>>>%@",@""]);
        if (yn) {
            [[UIApplication sharedApplication].keyWindow showHUDFailTips:strErrorMsg?:[NSString stringWithFormat:@"服务器开小差啦>>>%@",@""] hideDelay:kSCXHUDHideDelay];
        }
    };
    
    if ([[METHOD lowercaseString] isEqualToString:@"get"]) {
       
        task = [manager GET:urlString parameters:params progress:^(NSProgress *downloadProgress) {
            
        } success:^(NSURLSessionDataTask *task, id responseObject) {
            
            !af_success_cb?:af_success_cb((NSHTTPURLResponse*)task.response,responseObject);
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            !af_error_cb?:af_error_cb((NSHTTPURLResponse*)task.response,error);
            
        }];
    }else if([[METHOD lowercaseString] isEqual:@"post"]) {
        
        if (imageArray.count) {//图片上传
            
            task = [manager POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData){
                
                for (NSInteger i = 0; i < imageArray.count; i++ ) {
                    //取出图片
                    UIImage *image = (UIImage *)imageArray[i];
                    //把图片转换成data数据
                    NSData * imageData = UIImageJPEGRepresentation(image, 1);
                    //imageKey
                    NSString * imageKey = [NSString stringWithFormat:@"image[%zd]",i];
                    [formData appendPartWithFileData:imageData name:imageKey fileName:[NSString stringWithFormat:@"%@.jpg", imageKey] mimeType:@"image/jpeg"];
                }
            }progress:^(NSProgress *uploadProgress){
            }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject){
  
                !af_success_cb?:af_success_cb((NSHTTPURLResponse*)task.response,responseObject);
                
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
                !af_error_cb?:af_error_cb((NSHTTPURLResponse*)task.response,error);
            }];
            
        }else {
            task = [manager POST:urlString parameters:params progress:^(NSProgress *uploadProgress) {
                
            } success:^(NSURLSessionDataTask *task, id responseObject) {
                
                !af_success_cb?:af_success_cb((NSHTTPURLResponse*)task.response,responseObject);
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
                !af_error_cb?:af_error_cb((NSHTTPURLResponse*)task.response,error);
                
            }];
        }
    }
    return task;
}


/** 获取默认的AFHTTPRequestSerializer */
+ (AFHTTPRequestSerializer *)ptDefaultSerializer {

    AFHTTPRequestSerializer * t = [AFHTTPRequestSerializer serializer];
    //TODO:设置请求超时时间
    t.timeoutInterval = 20;
    //用户token
    NSString *userToken = [WLFileManager readUserDataForKey:kSCXUserSessionId];
//    if (userToken!=nil) {
    [t setValue:userToken?:@"" forHTTPHeaderField:kSCXUserSessionId];
//    }
    //唯一标识  暂时采用个推的
    NSString * getuiClientId = [WLFileManager readUserDataForKey:kSCXGetuiClientId];
    if (getuiClientId.length) {
        [t setValue:getuiClientId forHTTPHeaderField:@"uniqueIdentifier"];
    }
    //渠道码
    [t setValue:kSCXChannel_app forHTTPHeaderField:@"appChannel"];
    //来源
    [t setValue:@"iOS" forHTTPHeaderField:@"OSType"];
    //手机型号
    [t setValue:[self wl_getDeviceModel] forHTTPHeaderField:@"deviceModel"];
    //手机系统版本
    [t setValue:[[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"OSVersion"];
    //应用程序版本
    NSDictionary *dict = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [dict objectForKey:@"CFBundleShortVersionString"];
    [t setValue:app_Version forHTTPHeaderField:@"appVersion"];
    
    ///防止重复取出token传递出去唯一性 非空 请求头和参数各放一份
    NSString * token = [WLFileManager readUserDataForKey:kSCXToken];
    if (token.length) {
        [t setValue:token forHTTPHeaderField:kSCXToken];
    }
    return t;
}

/**  获取手机型号 eg: iphone6 iphoneX */
+ (NSString *)wl_getDeviceModel{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return deviceString;
}

@end
