//
//  UINavigationBar+WLNavigationBar.m
//  Yunmafu
//
//  Created by 王乐乐 on 2017/3/17.
//  Copyright © 2017年 wanglele. All rights reserved.
//

#import "UINavigationBar+WLNavigationBar.h"
#import <objc/runtime.h>
#import "UIImage+WLImage.h"
#import "UIViewController+WLViewController.h"


@implementation UINavigationBar (WLNavigationBar)

- (void)setWl_bgColor:(UIColor *)wl_bgColor{
    objc_setAssociatedObject(self, @selector(wl_bgColor), wl_bgColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setBackgroundImage:[UIImage imageWithColor:wl_bgColor] forBarMetrics:UIBarMetricsDefault];
    if ([wl_bgColor isEqual:[UIColor clearColor]]) {
        self.translucent = YES;
    }else {
        self.translucent = NO;
    }
}

- (UIColor *)wl_bgColor{
   return objc_getAssociatedObject(self, @selector(wl_bgColor));
}

/** 调用此设置分割线是否显示 建议在vc的viewWillAppear中设置 */
- (void)wl_sepLineHidden:(BOOL)yn {
    if (yn) {
        self.shadowImage = [UIImage new];
    }else {
        self.shadowImage = nil;
    }
}
@end
