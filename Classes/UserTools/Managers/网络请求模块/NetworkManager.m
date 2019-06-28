//
//  NetwrokManager.m
//  SCXiOS
//
//  Created by liuwj on 2019/1/15.
//  Copyright © 2019 wll. All rights reserved.
//

#import "NetworkManager.h"

#import <YYModel.h>
@implementation NetworkManager
+ (instancetype)shareManager{
    static NetworkManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[NetworkManager alloc]initWithBaseURL:nil];
    });
    return  manager;
}
- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self) return nil;
    //  self.requestSerializer = [AFHTTPRequestSerializer serializer];
    //  self.responseSerializer = [AFJSONResponseSerializer serializer];
    
    /**设置请求超时时间*/
    self.requestSerializer.timeoutInterval = 15;
    
    /**复杂的参数类型 需要使用json传值-设置请求内容的类型*/
    [self.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    
    [self.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable __autoreleasing * _Nullable error) {
        if ([parameters isKindOfClass:[NSString class]]) {
            return parameters;
        }
        
        if ([[request.HTTPMethod uppercaseString] isEqualToString:@"POST"])
        {
//            [];
            NSString *paramString = [parameters yy_modelToJSONString];
            
            return paramString;
        }else if([[request.HTTPMethod uppercaseString] isEqualToString:@"GET"] ){
            if ([parameters isKindOfClass:[NSDictionary class]]) {
                return AFQueryStringFromParameters(parameters);
            }
            return AFQueryStringFromParameters([parameters yy_modelToJSONObject]);
        }else {
            if ([parameters isKindOfClass:[NSDictionary class]]) {
                return AFQueryStringFromParameters(parameters);
            }
            return AFQueryStringFromParameters([parameters yy_modelToJSONObject]);
        }
        
        return parameters;
    }];
    /**设置接受的类型*/
    [self.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain",@"application/json",@"application/pdf",@"text/json",@"text/javascript",@"text/html",@"multipart/form-data", nil]];
    
    return self;
}

- (void)setupFormContentType{
    [self.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
}
+ (void)netwWork_get:(NSString *)urlString
              success:(NetworkSuccess)success
              failure:(NetworkFailure)failure
{
    [self net_requestType:NetworkRequestTypeGet
                urlString:urlString
               parameters:nil
                 progress:nil
                  success:success
                  failure:failure];
}
+ (void)netwWork_post:(NSString *)urlString
              success:(NetworkSuccess)success
              failure:(NetworkFailure)failure
{
    [self net_requestType:NetworkRequestTypePost
                urlString:urlString
               parameters:nil
                 progress:nil
                  success:success
                  failure:failure];
}
+ (void)netwWork_post:(NSString *)urlString
           parameters:(id)parameters
              success:(NetworkSuccess)success
              failure:(NetworkFailure)failure
{
    [self net_requestType:NetworkRequestTypePost
                urlString:urlString
               parameters:parameters
                 progress:nil
                  success:success
                  failure:failure];

}
+ (void)netWork_post:(NSString *)urlString
       parameters:(id)parameters
         progress:(NetworkProgress)progress
          success:(NetworkSuccess)success
          failure:(NetworkFailure)failure
{
    [self net_requestType:NetworkRequestTypePost
                  urlString:urlString
                 parameters:parameters
                   progress:progress
                    success:success
                    failure:failure];
}
+ (void)net_requestType:(NetworkRequestType)type
                urlString:(NSString *)urlString
               parameters:(id)parameters
                 progress:(NetworkProgress)progress
                  success:(NetworkSuccess)success
                  failure:(NetworkFailure)failure
{
    [self net_requestType:type
                  urlString:urlString
                 parameters:parameters
                   progress:progress
                    success:success
                    failure:failure
                loadingType:NetworkLoadingTypeNone
                     inView:nil];
}
+ (void)net_requestType:(NetworkRequestType)type
                urlString:(NSString *)urlString
               parameters:(id)parameters
                 progress:(NetworkProgress)progress
                  success:(NetworkSuccess)success
                  failure:(NetworkFailure)failure
              loadingType:(NetworkLoadingType)loadingType     // 备用
                   inView:(UIView *)inView;                      // 备用
{
    // [[self shareManager] addHeader];
    
    
    switch (type) {
        case NetworkRequestTypeGet:
        {
            [[self shareManager] GET:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                if (progress) progress(downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    NetworkResponse *responce = [NetworkResponse yy_modelWithDictionary:responseObject];
                    success(task, responce);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(task, error);
                }
            }];
        }
            break;
        case NetworkRequestTypePost:
        {
            [[self shareManager] POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                if (progress) progress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if (success) {
                    NetworkResponse *responce = [NetworkResponse yy_modelWithDictionary:responseObject];
//                    if ([responce.code isEqualToString:Login]) {
//                        [[NSNotificationCenter defaultCenter] postNotificationName:Notification__Relogin object:nil];
//                    }
                    success(task, responce);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(task, error);
                }
            }];
        }
            break;
  
    }
}
@end
