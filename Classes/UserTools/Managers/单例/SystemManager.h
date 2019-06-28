//
//  SystemManager.h
//  SCXiOS
//
//  Created by liuwj on 2019/1/19.
//  Copyright © 2019 wll. All rights reserved.
//

#import "BaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface SystemManager : BaseObject
+ (instancetype)sharedInstance;

@property (nonatomic, copy)NSString *aliyuncsOssAccessKeyId;//" : "LTAIvoii9psKcbOF",
@property (nonatomic, copy)NSString *aliyuncsOssAccessKeySecret;//" : "Ds76c4vrkuBBQHLRiqQk2R7ZmxSA4o",
@property (nonatomic, copy)NSString *refreshDelayTime;//" : "1000",
@property (nonatomic, copy)NSString *aliyuncsOssBacketName;//" : "yiyuanyungoutest",
@property (nonatomic, copy)NSString *aliyuncsOssDomain;//" : "http://yiyuanyungoutest.oss-cn-shanghai.aliyuncs.com",
@property (nonatomic, copy)NSString *aliyuncsOssEndpoint;//" : "http://oss-cn-shanghai.aliyuncs.com"
@end

NS_ASSUME_NONNULL_END
