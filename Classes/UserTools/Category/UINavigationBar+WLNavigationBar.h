//
//  UINavigationBar+WLNavigationBar.h
//  Yunmafu
//
//  Created by 王乐乐 on 2017/3/17.
//  Copyright © 2017年 wanglele. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (WLNavigationBar)
/** 根据颜色生成图片 设置setBackgroundImage: forBarMetrics: 建议在vc的viewWillAppear中设置 */
@property (nonatomic, strong) UIColor * wl_bgColor;

/** 调用此设置分割线是否显示 建议在vc的viewWillAppear中设置 */
- (void)wl_sepLineHidden:(BOOL)yn;

@end
