//
//  UIBarButtonItem+WLBarButtonItem.m
//  Yunmafu
//
//  Created by 王乐乐 on 2017/2/20.
//  Copyright © 2017年 wanglele. All rights reserved.
//

#import "UIBarButtonItem+WLBarButtonItem.h"
//#import <ReactiveObjC.h>


@implementation UIBarButtonItem (WLBarButtonItem)

#pragma mark __________控件兵工厂___________

/**
 *  快捷创建导航按钮 注意循环引用
 *  @param  imageNamed 正常图片
 *  @param  callBack 点击回调
 *  @return return UIBarButtonItem
 */
+ (instancetype)wl_itemWithImage:(NSString *)imageNamed callBack:(void(^)(UIButton * btn))callBack {
    return [UIBarButtonItem wl_itemWithImage:imageNamed highImage:imageNamed callBack:callBack];
}

/**
 *  快捷创建导航按钮 注意循环引用
 *  @param  title 标题
 *  @param  callBack 点击回调
 *  @return return UIBarButtonItem
 */
+ (instancetype)wl_itemWithTitle:(NSString *)title callBack:(void(^)(UIButton * btn))callBack {
    return [UIBarButtonItem wl_itemWithTitleColor:UIColorFromRGB(0x333333) title:title callBack:callBack];
}

/**
 *  快捷创建导航按钮 注意循环引用
 *  @param  image 正常图片
 *  @param  highImage 高亮图片
 *  @param  callBack 点击回调
 *  @return return UIBarButtonItem
 */
+ (instancetype)wl_itemWithImage:(NSString *)image highImage:(NSString *)highImage callBack:(void(^)(UIButton * btn))callBack{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
//    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        !callBack?:callBack(button);
//    }];
    [button sizeToFit];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

/**
 *  快捷创建导航按钮 注意循环引用
 *  @param  titleColor 标题颜色
 *  @param  title 标题
 *  @param  callBack 点击回调
 *  @return return UIBarButtonItem
 */
+ (instancetype)wl_itemWithTitleColor:(UIColor *)titleColor title:(NSString *)title callBack:(void(^)(UIButton * btn))callBack{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
//    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        !callBack?:callBack(button);
//    }];
    [button sizeToFit];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}




@end
