//
//  NetwrokManager.h
//  SCXiOS
//
//  Created by liuwj on 2019/1/15.
//  Copyright © 2019 wll. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "NetworkResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager : AFHTTPSessionManager

typedef NS_ENUM(NSUInteger ,NetworkRequestType){
    NetworkRequestTypeGet = 0, // GET
    NetworkRequestTypePost = 1, // POST
};

typedef NS_ENUM(NSUInteger, NetworkLoadingType) {
    NetworkLoadingTypeNone = 0,
    NetworkLoadingTypeNormal
};

typedef void (^NetworkSuccess)(NSURLSessionTask *task, NetworkResponse *response);
typedef void (^NetworkFailure)(NSURLSessionTask *task, NSError *error);
typedef void (^NetworkProgress)(CGFloat progress);
/**
 *  单例方法
 *
 *  @return 实例对象
 */
+ (instancetype)shareManager;
/**
 *  设置表单的的ContentType
 */
- (void)setupFormContentType;
/**
 *  网络请求的类方法 post请求
 *
 *  @param urlString    请求的地址
 *  @param parameters    请求的参数
 *  @param success      请求成功的回调 responseObj未经过处理
 *  @param failure      请求失败的回调
 */
+ (void)netwWork_post:(NSString *)urlString
       parameters:(id)parameters
          success:(NetworkSuccess)success
          failure:(NetworkFailure)failure;
/**
*
*  网络请求的类方法 post请求
*
*  @param urlString    请求的地址
*  @param success      请求成功的回调 responseObj未经过处理
*  @param failure      请求失败的回调
*/
+ (void)netwWork_post:(NSString *)urlString
              success:(NetworkSuccess)success
              failure:(NetworkFailure)failure;
/**
 *
 *  网络请求的类方法 get请求
 *
 *  @param urlString    请求的地址
 *  @param success      请求成功的回调 responseObj未经过处理
 *  @param failure      请求失败的回调
 */
+ (void)netwWork_get:(NSString *)urlString
              success:(NetworkSuccess)success
              failure:(NetworkFailure)failure;

@end

NS_ASSUME_NONNULL_END
