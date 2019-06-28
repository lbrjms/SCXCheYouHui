//
//  SCXBaseVC.h
//  SCXiOS
//
//  Created by liuwj on 2019/1/8.
//  Copyright © 2019 wll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+WLViewController.h"


@interface SCXBaseVC : UIViewController
//self.navigationController.navigationBar.translucent = YES;
//[self.navigationController.navigationBar setBackgroundImage:[UIImage new]  forBarMetrics:UIBarMetricsDefault];

/**
 导航栏透明
 */
@property(nonatomic,assign)BOOL navigationBarClear;



@end
