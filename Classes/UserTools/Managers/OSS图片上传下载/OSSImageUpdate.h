    //
    //  OSSImageUpdate.h
    //  JB
    //
    //  Created by 上海嘉礴1 on 16/9/18.
    //  Copyright © 2016年 yuyunzhang. All rights reserved.
    //

#import <Foundation/Foundation.h>

//#define ALLOT_PATH  @"allot"
//#define ACCESCX_PATH @"accept"
//#define DISPATCH_PATH  @"dispatch"
//#define REPAIR_PATH  @"repair"
//#define WORKORDER_PATH  @"workorder"
//#define UPKEEP_PATH @"upkeep"
//#define TRAIN_PATH  @"train"
#define PATH_AVATAR @"avatar"


typedef NS_ENUM(NSInteger, UploadImageState) {
    UploadImageFailed   = 0,
    UploadImageSuccess  = 1
};

@interface OSSImageUpdate : NSObject

@property (nonatomic, strong) NSString *filePath;

+ (void)asyncUploadImage:(UIImage *)image complete:(void(^)(NSArray<NSString *> *names,UploadImageState state))complete;

+ (void)asyncUploadImages:(NSArray<UIImage *> *)images complete:(void(^)(NSArray<NSString *> *names,UploadImageState state))complete;

/**
 异步单张图片长传-带服务器自动回调
 
 @param images  长传的图片数组
 @param success 回调信息
 @param error   错误信息
 */
+ (void)asyncUploadImage:(UIImage *)image path:(NSString *)path success:(void(^)(id response))success failure:(void(^)(NSError *error))error;


/**
 异步多张图片长传-带服务器自动回调
 
 @param images  长传的图片数组
 @param success 回调信息
 @param error   错误信息
 */
+ (void)asyncUploadImages:(NSArray<UIImage *> *)images path:(NSString *)path success:(void(^)(id response))success failure:(void(^)(NSError *error))error;
    //文件下载
+ (void)downloadFileWithFileUrl:(NSString *)fileUrl;


/**
 阿里云文件下载
 
 @param url      文件路径（阿里云路径和本地存储路径为同一个）
 @param progress 下载进度
 @param success  下载成功
 @param error    下载失败
 */
+ (void)downloadFileWithUrl:(NSString *)url progress:(void(^)(float progress))progress success:(void(^)(id response))success failure:(void(^)(NSError *error))error;


@end
