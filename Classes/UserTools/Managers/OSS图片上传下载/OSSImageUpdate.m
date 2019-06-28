    //
    //  OSSImageUpdate.m
    //  JB
    //
    //  Created by 上海嘉礴1 on 16/9/18.
    //  Copyright © 2016年 yuyunzhang. All rights reserved.
    //

#import "OSSImageUpdate.h"
#import "SystemManager.h"
#import <AliyunOSSiOS/OSSService.h>

@implementation OSSImageUpdate

static NSString *const AccessKey = @"LTAIvoii9psKcbOF";
static NSString *const SecretKey = @"Ds76c4vrkuBBQHLRiqQk2R7ZmxSA4o";
static NSString *const BucketName = @"yiyuanyungoutest";
NSString * const endPoint = @"http://oss-cn-shanghai.aliyuncs.com";

static NSString *kTempFolder = @"avatar";
static NSString *KFeadback = @"feadback";

#pragma mark - 图片上传
+ (void)asyncUploadImage:(UIImage *)image complete:(void(^)(NSArray<NSString *> *names,UploadImageState state))complete
{
    [self uploadImages:@[image] isAsync:YES complete:complete temp:kTempFolder];
}

+ (void)asyncUploadImages:(NSArray<UIImage *> *)images complete:(void(^)(NSArray<NSString *> *names,UploadImageState state))complete
{
    [self uploadImages:images isAsync:YES complete:complete temp:KFeadback];
}

+ (void)uploadImages:(NSArray<UIImage *> *)images isAsync:(BOOL)isAsync complete:(void(^)(NSArray<NSString *> *names, UploadImageState state))complete temp:(NSString *)temp
{}

#pragma mark ==带服务器自动回调
+ (void)asyncUploadImage:(UIImage *)image path:(NSString *)path success:(void(^)(id response))success failure:(void(^)(NSError *error))error
{
    [self uploadImages:@[image] path:(NSString *)path success:success failure:error];
}

+ (void)asyncUploadImages:(NSArray<UIImage *> *)images path:(NSString *)path success:(void(^)(id response))success failure:(void(^)(NSError *error))error
{
    [self uploadImages:images path:(NSString *)path success:success failure:error];
}

+ (void)uploadImages:(NSArray<UIImage *> *)images path:(NSString *)path success:(void(^)(id response))success failure:(void(^)(NSError *error))error

{
//    id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:AccessKey                                                                                                            secretKey:SecretKey];
    id<OSSCredentialProvider> credential = [[OSSStsTokenCredentialProvider alloc] initWithAccessKeyId:AccessKey secretKeyId:SecretKey securityToken:@"SecurityToken"];

    
    OSSClient *client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = images.count;
    
    NSMutableArray *resultsArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *resultDic;
    NSMutableArray *resultsErrorCount = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < images.count; i++) {
        UIImage *image = images[i];
        if (image) {
            double  dateStr = [[NSDate date] timeIntervalSince1970];


            NSString *imageName = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%f.jpg",dateStr]];
            
            NSData *data = UIImageJPEGRepresentation(image, 0.3);
            
            OSSPutObjectRequest * request = [OSSPutObjectRequest new];
            request.bucketName = BucketName;
            request.objectKey = imageName;
            request.uploadingData = data;
            
            /*************设置回调结果***************/
            resultDic = [[NSMutableDictionary alloc] init];
            NSString *fileName = [NSString stringWithFormat:@"%f.jpg",dateStr];
            NSString *fileUrl = [NSString stringWithFormat:@"%@/%@/%@/%@",endPoint, BucketName, path, fileName];
            NSString *fileType = @"jpg";
            NSString *fileSize = [NSString stringWithFormat:@"%ld", data.length];
            NSString *fileSuffix = @"jpg";
            
            [resultDic setObject:fileName forKey:@"fileName"];
            [resultDic setObject:fileType forKey:@"fileType"];
            [resultDic setObject:fileUrl forKey:@"fileUrl"];
            [resultDic setObject:fileSize forKey:@"fileSize"];
            [resultDic setObject:fileSuffix forKey:@"fileSuffix"];
            /**************************************/
            
            request.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
            };
            
            OSSTask * putTask = [client putObject:request];
            
            [putTask continueWithBlock:^id(OSSTask *task) {
                if (task.error) {
                    OSSLogError(@"%@", task.error);
                    [resultsErrorCount addObject:task.error];
                    if (error) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            error(task.error);
                        });
                        
                    }
                    return nil;
                } else {
//                    OSSPutObjectResult * result = task.result;
                    [resultsArray addObject:resultDic];
                    if (i == (images.count - 1)) {
                        while (resultsArray.count < images.count) {
                            sleep(0.1);
                        }
                        if (success) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                success(resultsArray);
                            });
                        }
                    }
                }
                return nil;
            }];
            
        }
    }
    
}
    //文件下载
+ (void)downloadFileWithFileUrl:(NSString *)fileUrl
{
    OSSGetObjectRequest * request = [OSSGetObjectRequest new];
    
        // 必填字段
    request.bucketName = BucketName;
    request.objectKey = fileUrl;
    
        // 可选字段
    request.downloadProgress = ^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
            // 当前下载段长度、当前已经下载总长度、一共需要下载的总长度
        NSLog(@"%lld, %lld, %lld", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
    };
        // request.range = [[OSSRange alloc] initWithStart:0 withEnd:99]; // bytes=0-99，指定范围下载
        // request.downloadToFileURL = [NSURL fileURLWithPath:@"<filepath>"]; // 如果需要直接下载到文件，需要指明目标文件地址
    id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:AccessKey                                                                                                            secretKey:SecretKey];
    OSSClient *client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential];
    OSSTask * getTask = [client getObject:request];
    
    [getTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            NSLog(@"download object success!");
            OSSGetObjectResult * getResult = task.result;
            NSLog(@"download result: %@", getResult.downloadedData);
        } else {
            NSLog(@"download object failed, error: %@" ,task.error);
        }
        return nil;
    }];
    
    [getTask waitUntilFinished];
    
    [request cancel];
    
}

#pragma mark - 文件下载
+ (void)downloadFileWithUrl:(NSString *)url progress:(void(^)(float progress))progress success:(void(^)(id response))success failure:(void(^)(NSError *error))error{
    id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:AccessKey                                                                                                            secretKey:SecretKey];
    
    OSSClient *client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential];
    
    OSSGetObjectRequest * request = [OSSGetObjectRequest new];
        // 必填字段
    request.bucketName = BucketName;
    request.objectKey = url;
    
        // 可选字段
    request.downloadProgress = ^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
            // 当前下载段长度、当前已经下载总长度、一共需要下载的总长度
        NSLog(@"%lld, %lld, %lld", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
        if (progress) {
            progress((float)totalBytesWritten/totalBytesExpectedToWrite);
        }
    };
    
        // 文件存储路径
    
    NSString *Document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [Document stringByAppendingPathComponent:url];
    
    request.downloadToFileURL = [NSURL fileURLWithPath:path]; // 如果需要直接下载到文件，需要指明目标文件地址
    
    
    OSSTask * getTask = [client getObject:request];
    
    [getTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            NSLog(@"download object success!");
            OSSGetObjectResult * getResult = task.result;
            NSLog(@"download result: %@", getResult);
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(getResult.objectMeta);
                });
            }
        } else {
            NSLog(@"download object failed, error: %@" ,task.error);
            if (error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    error(task.error);
                });
            }
        }
        return nil;
    }];
    
}

@end
