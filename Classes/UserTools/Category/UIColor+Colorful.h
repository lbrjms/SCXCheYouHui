//
//  UIColor+Colorful.h
//  JB
//
//  Created by haishang on 2017/2/23.
//  Copyright © 2017年 yuyunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Colorful)
/**
 color
 
 @param hexString 16进制
 @return rgb
 */
+ (UIColor *)colorWithHexString: (NSString *)hexString;
@end
