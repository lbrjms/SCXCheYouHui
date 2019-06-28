//
//  SCXUserInfoManager.h
//  SCXiOS
//
//  Created by wll on 2019/1/24.
//  Copyright © 2019 wll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLSingle.h"
#import "AccountModel.h"

/**
 用户信息存储模块
 */
@interface SCXUserInfoManager : NSObject

@property (nonatomic, strong) AccountModel * userModel;

SingleH(SCXUserInfoManager)


/**
 弹出登录界面 内部会判断是否登录 已登录不弹
 */
+ (void)showLogInVC;


/**
 清除用户信息
 */
+ (void)clearUserInfo;

/**
 是否登录
 */
+ (BOOL)isLogIn;

/** 写入用户 写入nil 即为清除用户信息 */
+ (void)writeUser:(AccountModel *)user;

/** 读取保存的用户 */
+ (AccountModel *)readUser;

/** 刷新用户信息并保存 */
+ (void)refreshUserInfo;

@end
