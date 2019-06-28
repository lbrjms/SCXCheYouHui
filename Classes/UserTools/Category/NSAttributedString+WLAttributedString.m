//
//  NSAttributedString+WLAttributedString.m
//  SCXiOS
//
//  Created by wll on 2019/1/10.
//  Copyright © 2019 wll. All rights reserved.
//

#import "NSAttributedString+WLAttributedString.h"

@implementation NSAttributedString (WLAttributedString)

/** 根据文本计算高度 */
- (CGFloat)calculateAttributeTextHeightByTextViewWithlimitWidth:(CGFloat)limitWidth {
    
    UITextView * tV = [[UITextView alloc] init];
    CGFloat padding = tV.textContainer.lineFragmentPadding;
    tV.textContainerInset = UIEdgeInsetsMake(0, -padding, 0, -padding);
    tV.attributedText = self;
    tV.bounds = CGRectMake(0, 0, limitWidth, 0);
    [tV sizeToFit];
    return tV.bounds.size.height;
}

@end
