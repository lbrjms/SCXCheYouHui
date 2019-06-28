//
//  UIImage+WLImage.h
//  Kangyx
//
//  Created by 王乐乐 on 16/9/19.
//  Copyright © 2016年 Wanglele. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WLImage)

/** 获取启动图 */
+ (instancetype)wl_getLaunchImage;

/** 根据字符串生成指定颜色大小的黑白二维码 */
+ (UIImage *)wl_createQRImageWithString:(NSString *)string bgColor:(UIColor *)bgColor contentColor:(UIColor *)ctColor size:(CGSize)size;

/** 截屏根据view */
+ (UIImage *)wl_captureWithView:(UIView *)view;

/**根据颜色生成图片*/
+ (UIImage *)imageWithColor:(UIColor *)color;

/**根据颜色和大小生成图片*/
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**一个点的颜色*/
- (UIColor *)colorAtPoint:(CGPoint )point;

//more accurate method ,colorAtPixel 1x1 pixel
/**一个像素的颜色*/
- (UIColor *)colorAtPixel:(CGPoint)point;

/**返回该图片是否有透明度通道*/
- (BOOL)hasAlphaChannel;

/** 图片裁剪 */
- (UIImage *)cb_scaleToSize:(CGSize)size;

/**
 重新生成带透明度的图片
 
 @param alpha 透明度
 @param image 原图
 @return 目标图
 */
- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image;

@end
