//
//  NSString+WLString.h
//  SCXiOS
//
//  Created by wll on 2019/1/10.
//  Copyright © 2019 wll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WLString)

/** 计算文本高度 */
- (CGFloat)calculateTextHeightByTextViewWithFont:(UIFont *)font limitWidth:(CGFloat)limitWidth;
/**
 处理富文本 数组要 11对应
 
 @param strArr 内容
 @param fontArr 字体
 @param colorArr 颜色
 @return 处理好的字符串
 */
+ (NSAttributedString *)stringWithStrArray:(NSArray<NSString *> *)strArr fontArray:(NSArray<NSNumber *> *)fontArr colorArray:(NSArray<UIColor *> *)colorArr;

/**
 处理富文本 数组要 11对应
 
 @param strArr 内容
 @param fontArr 字体
 @param colorArr 颜色
 @param lineSpace 行间距
 @param textAligmen 居向
 @return 处理好的字符串
 */
+ (NSAttributedString *)stringWithStrArray:(NSArray<NSString *> *)strArr fontArray:(NSArray<NSNumber *> *)fontArr colorArray:(NSArray<UIColor *> *)colorArr lineSpace:(CGFloat)lineSpace textAligment:(NSTextAlignment)textAligmen;
/**
 处理字符串加横线
 
 @return 处理好的字符串
 
 */
+ (NSString *)throughLineStringWithStr:(NSString *)str;

/**
 处理富文本 最后一个加横线
 数组要 11对应
 
 @param strArr 内容
 @param fontArr 字体
 @param colorArr 颜色
 @param lineSpace 行间距
 @return 处理好的字符串
 */
+ (NSAttributedString *)throughLineStringWithStrArray:(NSArray<NSString *> *)strArr
                                            fontArray:(NSArray<NSNumber *> *)fontArr
                                           colorArray:(NSArray<UIColor *> *)colorArr
                                            lineSpace:(CGFloat)lineSpace;

/**
 处理富文本 最后一个加横线
 数组要 11对应
 
 @param strArr 内容
 @param fontArr 字体
 @param colorArr 颜色
 @param lineSpace 行间距
 @param textAligmen 靠边
 @return 处理好的字符串
 
 */

+ (NSAttributedString *)throughLineStringWithStrArray:(NSArray<NSString *> *)strArr
                                            fontArray:(NSArray<NSNumber *> *)fontArr
                                           colorArray:(NSArray<UIColor *> *)colorArr
                                            lineSpace:(CGFloat)lineSpace
                                         textAligment:(NSTextAlignment)textAligmen;
/**
 处理富文本 最后一个加横线
 数组要 11对应
 
 @param strArr 内容
 @param fontArr 字体
 @param colorArr 颜色
 @param lineSpace 行间距
 @param textAligmen 靠边
 @param throughLineColor e横线的颜色

 @return 处理好的字符串
 
 */

+ (NSAttributedString *)throughLineStringWithStrArray:(NSArray<NSString *> *)strArr
                                            fontArray:(NSArray<NSNumber *> *)fontArr
                                           colorArray:(NSArray<UIColor *> *)colorArr
                                            lineSpace:(CGFloat)lineSpace
                                         textAligment:(NSTextAlignment)textAligmen
                                         throughLineColor:(UIColor *)throughLineColor;
#pragma mark - 获取当前时间的 时间戳

+(NSInteger)getNowTimestamp;
/**
 *  时间戳转时间
 */
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString;

/**
 返回字符串的宽高
 */
+ (CGSize)boundingRectWithWidth:(CGSize)size font:(float)font content:(NSString *)str;
- (NSString *)md5String;
-(NSString *)createMD5SingForPayWithAppID:(NSString *)appid_key partnerid:(NSString *)partnerid_key prepayid:(NSString *)prepayid_key package:(NSString *)package_key noncestr:(NSString *)noncestr_key timestamp:(UInt32)timestamp_key;
/**
 倒计时
 */
+ (NSString *)timeCountDownInfoWithString:(NSInteger)timeIntrval;
@end
