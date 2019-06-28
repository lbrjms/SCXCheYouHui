//
//  SCXNetServerTool.h
//  SCXiOS
//
//  Created by wll on 2019/1/15.
//  Copyright © 2019 wll. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFHTTPRequestSerializer;

typedef void(^successHandler)(id responseObject,NSInteger statusCode);
typedef void(^failHandler)(NSError * error,NSInteger statusCode,NSString * errorMsg);

@interface SCXNetServerTool : NSObject

/** 获取默认的AFHTTPRequestSerializer */
+ (AFHTTPRequestSerializer *)ptDefaultSerializer;


/**
 GET请求 注意不要携带域名或者ip 内部会自动拼接kSCXBaseUrl
 @param urlString 请求地址 不带baseUrl
 @param params 请求参数
 @param successBlk 请求成功回调
 @param failureBlk 请求失败回调
 @param yn 是否显示加载框
 @return NSURLSessionTask 可以用于取消请求
 */
+ (NSURLSessionTask *)getRequestWithURL:(NSString *)urlString param:(NSDictionary *)params success:(successHandler)successBlk failure:(failHandler)failureBlk showHUD:(BOOL)yn;

/**
 POST请求 注意不要携带域名或者ip 内部会自动拼接kSCXBaseUrl
 @param urlString 请求地址 不带baseUrl
 @param params 请求参数
 @param successBlk 请求成功回调
 @param failureBlk 请求失败回调
 @param yn 是否显示加载框
 @return NSURLSessionTask 可以用于取消请求
 */
+ (NSURLSessionTask *)postRequestWithURL:(NSString *)urlString param:(NSDictionary *)params success:(successHandler)successBlk failure:(failHandler)failureBlk showHUD:(BOOL)yn;


/**
 单张或者多张 注意不要携带域名或者ip 内部会自动拼接kSCXBaseUrl
 @param imageArray 图片数组
 @param urlString 请求地址 不带baseUrl
 @param param 请求参数
 @param successBlk 请求成功回调
 @param failureBlk 请求成功回调
 @param yn 是否显示加载框
 @return NSURLSessionTask 可以用于取消请求
 */
+ (NSURLSessionTask *)uploadImageWithArray:(NSArray <UIImage *>*)imageArray url:(NSString *)urlString param:(NSDictionary *)param success:(successHandler)successBlk failure:(failHandler)failureBlk showHUD:(BOOL)yn;
+ (NSURLSessionTask *)postRequestWithURL:(NSString *)urlString params:(NSArray *)params success:(successHandler)successBlk failure:(failHandler)failureBlk showHUD:(BOOL)yn ;
@end
