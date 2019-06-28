//
//  AppDelegate+SCXAppDelegate.m
//  SCXiOS
//
//  Created by wll on 2019/1/15.
//  Copyright © 2019 wll. All rights reserved.
//

#import "AppDelegate+SCXAppDelegate.h"
#import <AFNetworkReachabilityManager.h>


@implementation AppDelegate (SCXAppDelegate)


- (void)initializeThirdparty {
    
    //网络状态监听开启
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    //注册推送
    UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes: UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
    [[UIApplication sharedApplication] currentUserNotificationSettings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];

}


#pragma mark  _________________第三方回调相关处理____________________
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation{
   
    
    return YES;
}


//NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options{
  
    
    return YES;
}
#pragma mark  _________________第三方回调相关处理____________________



#pragma mark  _________________推送相关____________________
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"\n>>>[DeviceToken Success]:%@\n\n", token);
    
    //向个推服务器注册deviceToken
}

#pragma mark - GetuiDelegate



#pragma mark _________________启动主界面展示逻辑______________________
//TODO: 引导页
- (void)intoGuideVC {
    

    NSString * oldVersion = [[NSUserDefaults standardUserDefaults] stringForKey:@"CFBundleShortVersionString"];
    NSString * currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    if ([oldVersion isEqualToString:currentVersion]) {
        
        NSDictionary * dic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:kSCXLaunchADInfoKey];
        if ([dic[@"isShow"] boolValue]) {
            self.window.rootViewController = [NSClassFromString(@"SCXLaunchADVC") new];
        }else {
            self.window.rootViewController = [NSClassFromString(@"SCXTabBarVC") new];
        }
    }else {
        self.window.rootViewController = [NSClassFromString(@"SCXGuideVC") new];
    }
}
#pragma mark _________________启动主界面展示逻辑______________________


@end
