//
//  NSString+WLString.m
//  SCXiOS
//
//  Created by wll on 2019/1/10.
//  Copyright © 2019 wll. All rights reserved.
//

#import "NSString+WLString.h"
#import "NSAttributedString+WLAttributedString.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (WLString)

/** 计算文本高度 */
- (CGFloat)calculateTextHeightByTextViewWithFont:(UIFont *)font limitWidth:(CGFloat)limitWidth {
    NSAttributedString * att = [[NSAttributedString alloc] initWithString:self attributes:@{NSFontAttributeName:font}];
    
    
    return [att calculateAttributeTextHeightByTextViewWithlimitWidth:limitWidth];
}

+ (NSAttributedString *)stringWithStrArray:(NSArray<NSString *> *)strArr fontArray:(NSArray<NSNumber *> *)fontArr colorArray:(NSArray<UIColor *> *)colorArr{
 
    return [NSString stringWithStrArray:strArr fontArray:fontArr colorArray:colorArr lineSpace:9999 textAligment:NSTextAlignmentLeft];
}

+ (NSAttributedString *)stringWithStrArray:(NSArray<NSString *> *)strArr fontArray:(NSArray<NSNumber *> *)fontArr colorArray:(NSArray<UIColor *> *)colorArr lineSpace:(CGFloat)lineSpace textAligment:(NSTextAlignment)textAligment {
    NSMutableParagraphStyle * pa = [NSMutableParagraphStyle new];
    if (lineSpace != 9999) {
        pa.lineSpacing = lineSpace;
    }
    pa.alignment = textAligment;
    NSMutableAttributedString * totalStr = [[NSMutableAttributedString alloc] initWithString:@""];
    for (NSInteger i=0; i < strArr.count; i++ ) {
        [totalStr appendAttributedString:[[NSAttributedString alloc] initWithString:strArr[i] attributes:@{NSForegroundColorAttributeName:colorArr[i],NSFontAttributeName:[UIFont systemFontOfSize:fontArr[i].integerValue],NSParagraphStyleAttributeName:pa}]];
    }
    return totalStr;
}

+ (NSString *)throughLineStringWithStr:(NSString *)str
{
    NSMutableAttributedString * totalStr = [[NSMutableAttributedString alloc] initWithString:str];
//    [totalStr addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, totalStr.length)];
//    [totalStr addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, totalStr.length)];
 
    [totalStr setAttributes:@{NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle), NSBaselineOffsetAttributeName : @(NSUnderlineStyleSingle),NSStrikethroughColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0,totalStr.length)];
    return [totalStr string];
}
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
                                            lineSpace:(CGFloat)lineSpace
{
    NSMutableParagraphStyle * pa = [NSMutableParagraphStyle new];
    pa.lineSpacing = lineSpace;
    pa.alignment = NSTextAlignmentCenter;
    NSMutableAttributedString * totalStr = [[NSMutableAttributedString alloc] initWithString:@""];
    for (NSInteger i=0; i < strArr.count; i++ ) {
        NSMutableAttributedString *doingStr = [[NSMutableAttributedString alloc] initWithString:strArr[i] attributes:@{NSForegroundColorAttributeName:colorArr[i],NSFontAttributeName:[UIFont systemFontOfSize:fontArr[i].integerValue],NSParagraphStyleAttributeName:pa}];
        if (i==strArr.count-1) {
//            doingStr = [[NSMutableAttributedString alloc] initWithString:strArr[i] attributes:<#(nullable NSDictionary<NSAttributedStringKey,id> *)#>];
            [doingStr setAttributes:@{NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle), NSBaselineOffsetAttributeName : @(NSUnderlineStyleSingle),NSStrikethroughColorAttributeName:[UIColor grayColor],NSForegroundColorAttributeName:colorArr[i],NSFontAttributeName:[UIFont systemFontOfSize:fontArr[i].integerValue]} range:NSMakeRange(0,doingStr.length)];
            
        }
        [totalStr appendAttributedString:doingStr];
    }
    return totalStr;
}
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
                                         textAligment:(NSTextAlignment)textAligmen
{
    NSMutableParagraphStyle * pa = [NSMutableParagraphStyle new];
    pa.lineSpacing = lineSpace;
    pa.alignment = textAligmen;
    NSMutableAttributedString * totalStr = [[NSMutableAttributedString alloc] initWithString:@""];
    for (NSInteger i=0; i < strArr.count; i++ ) {
        NSMutableAttributedString *doingStr = [[NSMutableAttributedString alloc] initWithString:strArr[i] attributes:@{NSForegroundColorAttributeName:colorArr[i],NSFontAttributeName:[UIFont systemFontOfSize:fontArr[i].integerValue],NSParagraphStyleAttributeName:pa}];
        if (i==strArr.count-1) {
            [doingStr setAttributes:@{NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle), NSBaselineOffsetAttributeName : @(NSUnderlineStyleSingle),NSStrikethroughColorAttributeName:[UIColor grayColor],NSForegroundColorAttributeName:colorArr[i],NSFontAttributeName:[UIFont systemFontOfSize:fontArr[i].integerValue]} range:NSMakeRange(0,doingStr.length)];
            
        }
        [totalStr appendAttributedString:doingStr];
    }
    return totalStr;
}
+ (NSAttributedString *)throughLineStringWithStrArray:(NSArray<NSString *> *)strArr
                                            fontArray:(NSArray<NSNumber *> *)fontArr
                                           colorArray:(NSArray<UIColor *> *)colorArr
                                            lineSpace:(CGFloat)lineSpace
                                         textAligment:(NSTextAlignment)textAligmen
                                     throughLineColor:(UIColor *)throughLineColor
{
    NSMutableParagraphStyle * pa = [NSMutableParagraphStyle new];
    pa.lineSpacing = lineSpace;
    pa.alignment = textAligmen;
    NSMutableAttributedString * totalStr = [[NSMutableAttributedString alloc] initWithString:@""];
    for (NSInteger i=0; i < strArr.count; i++ ) {
        NSMutableAttributedString *doingStr = [[NSMutableAttributedString alloc] initWithString:strArr[i] attributes:@{NSForegroundColorAttributeName:colorArr[i],NSFontAttributeName:[UIFont systemFontOfSize:fontArr[i].integerValue],NSParagraphStyleAttributeName:pa}];
        if (i==strArr.count-1) {
            [doingStr setAttributes:@{NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle), NSBaselineOffsetAttributeName : @(NSUnderlineStyleSingle),NSStrikethroughColorAttributeName:throughLineColor,NSForegroundColorAttributeName:colorArr[i],NSFontAttributeName:[UIFont systemFontOfSize:fontArr[i].integerValue]} range:NSMakeRange(0,doingStr.length)];
            
        }
        [totalStr appendAttributedString:doingStr];
    }
    return totalStr;

}
#pragma mark - 获取当前时间的 时间戳

+(NSInteger)getNowTimestamp{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[datenow timeIntervalSince1970]] integerValue];
    return timeSp;
    
}

/**
 *  时间戳转时间
 */
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}
+ (CGSize)boundingRectWithWidth:(CGSize)size font:(float)font content:(NSString *)str
{
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    style.alignment = NSTextAlignmentLeft;
    
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font], NSParagraphStyleAttributeName:style}];
    
    CGSize returnSize =  [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    return returnSize;
}
- (NSString *)md5String
{
    if(self == nil || [self length] == 0) return nil;
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    for(i=0;i<CC_MD5_DIGEST_LENGTH;i++)
    {
        [ms appendFormat: @"%02x", (int)(digest[i])];
    }
    return [ms copy];
}
-(NSString *)createMD5SingForPayWithAppID:(NSString *)appid_key partnerid:(NSString *)partnerid_key prepayid:(NSString *)prepayid_key package:(NSString *)package_key noncestr:(NSString *)noncestr_key timestamp:(UInt32)timestamp_key{
    NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
    [signParams setObject:appid_key forKey:@"appid"];//微信appid 例如wxfb132134e5342
    [signParams setObject:noncestr_key forKey:@"noncestr"];//随机字符串
    [signParams setObject:package_key forKey:@"package"];//扩展字段  参数为 Sign=WXPay
    [signParams setObject:partnerid_key forKey:@"partnerid"];//商户账号
    [signParams setObject:prepayid_key forKey:@"prepayid"];//此处为统一下单接口返回的预支付订单号
    [signParams setObject:[NSString stringWithFormat:@"%u",timestamp_key] forKey:@"timestamp"];//时间戳
    
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [signParams allKeys];
    //1. 按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //2. 拼接字符串
    for (NSString *categoryId in sortedArray) {
        if (   ![[signParams objectForKey:categoryId] isEqualToString:@""]
            && ![[signParams objectForKey:categoryId] isEqualToString:@"sign"]
            && ![[signParams objectForKey:categoryId] isEqualToString:@"key"]
            )
        {
            [contentString appendFormat:@"%@=%@&", categoryId, [signParams objectForKey:categoryId]];
        }
    }
    //3. 添加商户密钥key字段  API 密钥
    [contentString appendFormat:@"key=%@", @"25700b4cbf7841c565865b183236a61f"];
    //4. md5加密
    NSString *result = [contentString md5String];
    return result;
}
/**
 倒计时
 */
+ (NSString *)timeCountDownInfoWithString:(NSInteger)timeIntrval
{
    
    if (timeIntrval<0) {
        timeIntrval=0;
    }
    NSInteger minute = timeIntrval / 60000;
    NSInteger second = (timeIntrval/1000)%60;
    NSInteger ss = (timeIntrval%1000)/10;
    return [NSString stringWithFormat:@"%02zd:%02zd:%02zd",minute,second,ss];
   
    
}
@end
