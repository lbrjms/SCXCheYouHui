//
//  AppDelegate.m
//  SCXiOS
//
//  Created by wll on 2019/1/8.
//  Copyright © 2019 wll. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+SCXAppDelegate.h"
#import <WebKit/WebKit.h>
#import "SCXNetServerTool.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    ///自动调整关掉
    if (@available(iOS 11.0, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [UITableView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [WKWebView appearance].scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [UICollectionView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [UIWebView appearance].scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    ///影响自动调整的 关掉
    [UINavigationBar appearance].translucent = NO;
    [UITabBar appearance].translucent = NO;
    ///关掉按钮的点击高亮
    [UIButton appearance].adjustsImageWhenHighlighted = NO;
    

    //第三方功能开启 例如 推送等服务
    [self initializeThirdparty];
    //TODO: 引导页广告页处理
    [self intoGuideVC];
    // 获取系统参数
    [self getSystemParam];
    [self.window makeKeyAndVisible];
    
    UIWebView *web = [[UIWebView alloc] init];
    NSString *userAgent = [web stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    userAgent = [userAgent stringByAppendingString:@"ios/ts"];
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent":userAgent}];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return YES;
}
- (void)getSystemParam
{
    [SCXNetServerTool getRequestWithURL:@"http://coolcuii.eicp.net/system/parameters" param:nil success:^(id responseObject, NSInteger statusCode) {
        //
        if ([responseObject[@"code"] isEqualToString:@"0"]) {
            NSDictionary *rsu = responseObject[@"result"];
            SystemManager *sys = [SystemManager sharedInstance];
            sys.refreshDelayTime = rsu[@"refreshDelayTime"];
            sys.aliyuncsOssAccessKeyId = rsu[@"aliyuncsOssAccessKeyId"];
            sys.aliyuncsOssAccessKeySecret = rsu[@"aliyuncsOssAccessKeySecret"];
            sys.aliyuncsOssBacketName = rsu[@"aliyuncsOssBacketName"];
            sys.aliyuncsOssDomain = rsu[@"aliyuncsOssDomain"];
            sys.aliyuncsOssEndpoint = rsu[@"aliyuncsOssEndpoint"];
        }
   

    } failure:^(NSError *error, NSInteger statusCode, NSString *errorMsg) {
        //
    } showHUD:NO];
}


/**
 * 切换到主视图
 * @param animation 是否动画
 */
- (void)setRootVCForKeyWindowanimation:(BOOL)animation{
    [self.window resignKeyWindow];
    self.window.rootViewController = [NSClassFromString(@"SCXTabBarVC") new];
    if (animation) {
        CATransition* transition = [CATransition animation];
        transition.duration = 0.25;
        transition.type = kCATransitionFade;
        transition.subtype = kCATransitionFromRight;
        [[UIApplication sharedApplication].keyWindow.layer addAnimation:transition forKey:kCATransition];
    }
    [self.window makeKeyAndVisible];
}

- (void)setRootVCForKeyWindowAnimation:(BOOL)animation tabbarSelectedIndex:(NSInteger)index{
    [self setRootVCForKeyWindowanimation:animation];
    UITabBarController * tabBar = (UITabBarController *)self.window.rootViewController;
    tabBar.selectedIndex = index;
}



@end
