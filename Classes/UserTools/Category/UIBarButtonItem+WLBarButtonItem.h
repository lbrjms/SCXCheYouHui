//
//  UIBarButtonItem+WLBarButtonItem.h
//  Yunmafu
//
//  Created by 王乐乐 on 2017/2/20.
//  Copyright © 2017年 wanglele. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+WLButton.h"

@interface UIBarButtonItem (WLBarButtonItem)

#pragma mark __________控件兵工厂___________

/**
 *  快捷创建导航按钮 注意循环引用
 *  @param  image 正常图片
 *  @param  callBack 点击回调
 *  @return return UIBarButtonItem
 */
+ (instancetype)wl_itemWithImage:(NSString *)image callBack:(void(^)(UIButton * btn))callBack;

/**
 *  快捷创建导航按钮 注意循环引用
 *  @param  title 标题
 *  @param  callBack 点击回调
 *  @return return UIBarButtonItem
 */
+ (instancetype)wl_itemWithTitle:(NSString *)title callBack:(void(^)(UIButton * btn))callBack;

/**
 *  快捷创建导航按钮 注意循环引用
 *  @param  image 正常图片
 *  @param  highImage 高亮图片
 *  @param  callBack 点击回调
 *  @return return UIBarButtonItem
 */
+ (instancetype)wl_itemWithImage:(NSString *)image highImage:(NSString *)highImage callBack:(void(^)(UIButton * btn))callBack;

/**
 *  快捷创建导航按钮 注意循环引用
 *  @param  titleColor 标题颜色
 *  @param  title 标题
 *  @param  callBack 点击回调
 *  @return return UIBarButtonItem
 */
+ (instancetype)wl_itemWithTitleColor:(UIColor *)titleColor title:(NSString *)title callBack:(void(^)(UIButton * btn))callBack;



@end
