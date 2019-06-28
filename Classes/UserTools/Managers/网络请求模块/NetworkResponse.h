//
//  NetworkResponse.h
//  SCXiOS
//
//  Created by liuwj on 2019/1/15.
//  Copyright © 2019 wll. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkResponse : NSObject
/** code */
@property (nonatomic, copy) NSString *code;
/** 错误信息 */
@property (nonatomic, copy) NSString *message;
/** 数据 */
@property (nonatomic, strong) id     result;
/** 是否成功  */
@property (nonatomic, assign, readonly) BOOL success;
@end

NS_ASSUME_NONNULL_END
