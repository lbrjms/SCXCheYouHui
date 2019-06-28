//
//  SCXBaseVC.m
//  SCXiOS
//
//  Created by liuwj on 2019/1/8.
//  Copyright © 2019 wll. All rights reserved.
//

#import "SCXBaseVC.h"

@interface SCXBaseVC ()

@end

@implementation SCXBaseVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self statusBarBlack];
    [self configNavigationBarItemTintColor:UIColorFromRGB(0x333333)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setNavigationBarClear:(BOOL)navigationBarClear
{
    if (navigationBarClear) {
        self.navigationController.navigationBar.backIndicatorImage = [UIImage new];

        // 一定要设置translucent这个属性否则不起作用
        self.navigationController.navigationBar.translucent = YES;
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new]  forBarMetrics:UIBarMetricsDefault];
        // 去掉导航栏的分割线
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        // 点击返回按钮回到导航栏透明的界面 导航栏闪现一下白色的问题
        self.navigationController.navigationBar.subviews.firstObject.alpha = 0;

    }else{
        self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"detail_back01"];
        self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"detail_back01"];

        [self.navigationController.navigationBar setBackgroundImage:nil  forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:nil];

    }
}
@end
