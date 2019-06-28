//
//  UIViewController+WLViewController.h
//  SCXiOS
//
//  Created by wll on 2019/1/18.
//  Copyright © 2019 wll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (WLViewController)

/**
 设置状态栏字体为黑色
 */
- (void)statusBarBlack;

/**
 设置状态栏字体为白色
 */
- (void)statusBarLight;


/**
 设置navigationBar的元素色值 包含navigationItem title
 */
- (void)configNavigationBarItemTintColor:(UIColor *)tintColor;


@end
