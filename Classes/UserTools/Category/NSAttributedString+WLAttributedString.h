//
//  NSAttributedString+WLAttributedString.h
//  SCXiOS
//
//  Created by wll on 2019/1/10.
//  Copyright © 2019 wll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (WLAttributedString)

/** 根据文本计算高度 */
- (CGFloat)calculateAttributeTextHeightByTextViewWithlimitWidth:(CGFloat)limitWidth;

@end
