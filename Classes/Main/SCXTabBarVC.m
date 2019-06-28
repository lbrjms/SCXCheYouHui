//
//  SCXTabBarVC.m
//  SCXiOS
//
//  Created by wll on 2019/1/8.
//  Copyright © 2019 wll. All rights reserved.
//

#import "SCXTabBarVC.h"
#import "SCXNavVC.h"
#import "FPSLabel.h"

@interface SCXTabBarVC () <UITabBarControllerDelegate>

@end

@implementation SCXTabBarVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.tintColor = UIColorFromRGB(0xfa7000);
    
    [self wl_addChildVCWithVCName:@"SCXCheYouHuiVC",@"车友汇",@"classify",@"classify01",nil];
    
    self.delegate = self;

    
#ifdef DEBUG
    
    FPSLabel *label = [[FPSLabel alloc] initWithFrame:CGRectMake(30, 300, 50, 30)];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view.window addSubview:label];
    });
    
#endif
}

- (void)wl_addChildVCWithVCName:(NSString *)vcName,...{
    NSMutableArray * strArr = [NSMutableArray array];
    if (!vcName.length) {
        return;
    }
    id eachObj;
    va_list argumentList;
    va_start(argumentList, vcName);
    while ((eachObj = va_arg(argumentList, id))) {
        [strArr addObject:eachObj];
    }
    va_end(argumentList);
    Class  className =  NSClassFromString(vcName);
    UIViewController * vc = [className new];
    SCXNavVC * nav = [[SCXNavVC alloc] initWithRootViewController:vc];
    if (strArr.count > 2) {
        (void)[vc.tabBarItem initWithTitle:strArr[0] image:[UIImage imageNamed:strArr[1]] selectedImage:[UIImage imageNamed:strArr[2]]];
        [vc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: UIColorFromRGB(0x8c8c8c), NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        [vc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: UIColorFromRGB(0xfa7000), NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    }
    [self addChildViewController:nav];
}


//MARK: 、、、、、、、UITabBarControllerDelegate、、、、、、、、、
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    UIViewController * vc = viewController;
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        vc = [(UINavigationController *)viewController topViewController];
    }

    return YES;
}

@end
