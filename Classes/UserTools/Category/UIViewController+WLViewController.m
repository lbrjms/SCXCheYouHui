//
//  UIViewController+WLViewController.m
//  SCXiOS
//
//  Created by wll on 2019/1/18.
//  Copyright © 2019 wll. All rights reserved.
//

#import "UIViewController+WLViewController.h"
#import <objc/message.h>
#import "NSObject+WLObject.h"

@implementation UIViewController (WLViewController)

/**
 设置状态栏字体为黑色
 */
- (void)statusBarBlack {
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}

/**
 设置状态栏字体为白色
 */
- (void)statusBarLight {
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}


/**
 设置navigationBar的元素色值 包含navigationItem title
 */
- (void)configNavigationBarItemTintColor:(UIColor *)tintColor {
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:tintColor}];
    self.navigationController.navigationBar.tintColor = tintColor;
    
    
}
//- (void)setNavBarWlBgColor:(UIColor *)navBarWlBgColor {
//    objc_setAssociatedObject(self, @selector(navBarWlBgColor), navBarWlBgColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (UIColor *)navBarWlBgColor{
//    return objc_getAssociatedObject(self, @selector(navBarWlBgColor));
//}
//
//- (void)setNavBarTranslucent:(BOOL)navBarTranslucent {
//    objc_setAssociatedObject(self, @selector(navBarTranslucent), @(navBarTranslucent), OBJC_ASSOCIATION_ASSIGN);
//}
//
//- (BOOL)navBarTranslucent {
//    return [objc_getAssociatedObject(self, @selector(navBarTranslucent)) boolValue];
//}

@end
