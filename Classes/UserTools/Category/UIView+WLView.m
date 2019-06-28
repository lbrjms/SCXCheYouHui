//
//  UIView+WLView.m
//  SCXiOS
//
//  Created by wll on 2019/1/14.
//  Copyright © 2019 wll. All rights reserved.
//

#import "UIView+WLView.h"

@implementation UIView (WLView)

- (void)wl_clipCornerWith:(UIRectCorner)corner radio:(CGFloat)radio {
    CAShapeLayer * tLayer = [CAShapeLayer layer];
    tLayer.frame = self.bounds;
    //MARK:这个地方要么给clear 要么不给  否则会被渲染成view的背景色,导致圆角不显示
    //        tLayer.backgroundColor = UIColor.clear.cgColor
    tLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radio, radio)].CGPath;
    self.layer.mask = tLayer;
}

@end
