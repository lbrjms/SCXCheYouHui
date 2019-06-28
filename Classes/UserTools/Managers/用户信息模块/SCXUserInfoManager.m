//
//  SCXUserInfoManager.m
//  SCXiOS
//
//  Created by wll on 2019/1/24.
//  Copyright © 2019 wll. All rights reserved.
//

#import "SCXUserInfoManager.h"
#import "SCXNetServerTool.h"

@implementation SCXUserInfoManager

SingleM(SCXUserInfoManager)

- (AccountModel *)userModel {
    if (!_userModel) {
        _userModel = [SCXUserInfoManager readUser];
    }
    return _userModel;
}


/**
 弹出登录界面 内部会判断是否登录 已登录不弹
 */
+ (void)showLogInVC {

    UIViewController * selectedVC = [(UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController selectedViewController];
    if (![selectedVC isKindOfClass:[UINavigationController class]]) {
        selectedVC = selectedVC.navigationController;
    }
//    [SCXRouter routerWithActionType:@"toLogin" actionUrl:nil navigationController:(UINavigationController *)selectedVC];
}

/**
 清除用户信息
 */
+ (void)clearUserInfo {
    [WLFileManager saveUserData:@"" forKey:kSCXUserSessionId];
    [WLFileManager saveUserData:@{} forKey:kSCXUserInfoKey];
    [SCXUserInfoManager shareSCXUserInfoManager].userModel = nil;
}

/**
 是否登录
 */
+ (BOOL)isLogIn {
    return [[WLFileManager readUserDataForKey:kSCXUserSessionId] length];
}

//写入用户
+ (void)writeUser:(AccountModel *)user {
    if (user) {
        [WLFileManager saveUserData:[user yy_modelToJSONObject] forKey:kSCXUserInfoKey];
    }else {
        [WLFileManager saveUserData:@"" forKey:kSCXUserSessionId];
        [WLFileManager saveUserData:@{} forKey:kSCXUserInfoKey];
    }
    [SCXUserInfoManager shareSCXUserInfoManager].userModel = user;
}

//读取保存的用户
+ (AccountModel *)readUser {
    NSDictionary * dic = [WLFileManager readUserDataForKey:kSCXUserInfoKey];
    if (dic.allKeys.count) {
        return [AccountModel yy_modelWithJSON:dic];
    }
    return nil;
}

//TODO: 刷新用户信息并保存
+ (void)refreshUserInfo {
    
    [SCXNetServerTool postRequestWithURL:@"my/account" param:nil success:^(id responseObject, NSInteger statusCode) {
        
        if ([responseObject[@"code"] integerValue] == 0) {
            
            AccountModel * userModel =  [AccountModel yy_modelWithJSON:responseObject[@"result"]];
            [SCXUserInfoManager writeUser:userModel];
        }else {
            NSLog(@">>>>刷新用户信息失败");
            [[UIApplication sharedApplication].keyWindow showHUDFailTips:responseObject[@"message"] hideDelay:kSCXHUDHideDelay];

        }

    } failure:^(NSError *error, NSInteger statusCode, NSString *errorMsg) {
        NSLog(@">>>>刷新用户信息失败");
        [[UIApplication sharedApplication].keyWindow showHUDFailTips:errorMsg hideDelay:kSCXHUDHideDelay];

    } showHUD:NO];
}

@end
