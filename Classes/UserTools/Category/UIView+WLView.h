//
//  UIView+WLView.h
//  SCXiOS
//
//  Created by wll on 2019/1/14.
//  Copyright © 2019 wll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WLView)

/**
 切圆角

 @param corner 方位
 @param radio 圆角大小
 */
- (void)wl_clipCornerWith:(UIRectCorner)corner radio:(CGFloat)radio;

@end
