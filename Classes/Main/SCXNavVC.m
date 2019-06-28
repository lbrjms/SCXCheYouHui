//
//  SCXNavVC.m
//  SCXiOS
//
//  Created by wll on 2019/1/8.
//  Copyright © 2019 wll. All rights reserved.
//

#import "SCXNavVC.h"

@interface SCXNavVC ()

@property (nonatomic, strong) UIColor * lastNavBarWlBgColor;

@property (nonatomic, assign) BOOL lastNavBarTranslucent;

@property (nonatomic, strong) NSDictionary * lastTitleAttDic;



@end

@implementation SCXNavVC

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    //消除系统自带的返回标题
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    if (self.childViewControllers.count > 0) {
        

        // 替换系统的返回图片
        self.navigationBar.backIndicatorImage = [UIImage imageNamed:@"detail_back01"];
        self.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"detail_back01"];

        // 隐藏底部的工具条
        viewController.hidesBottomBarWhenPushed = YES;
    }
    self.lastNavBarWlBgColor = self.navigationBar.wl_bgColor;
    self.lastNavBarTranslucent = self.navigationBar.translucent;
    self.lastTitleAttDic = self.navigationBar.titleTextAttributes;
    // 所有设置搞定后, 再push控制器
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    if (self.lastNavBarWlBgColor) {
        self.navigationBar.wl_bgColor =  self.lastNavBarWlBgColor;
        self.navigationBar.translucent = self.lastNavBarTranslucent;
    }
    self.navigationBar.titleTextAttributes = self.lastTitleAttDic;
    return [super popViewControllerAnimated:animated];
}

@end
