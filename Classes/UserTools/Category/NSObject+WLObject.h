//
//  NSObject+WLObject.h
//  Yunmafu
//
//  Created by 王乐乐 on 2017/2/21.
//  Copyright © 2017年 wanglele. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIViewController;

@interface NSObject (WLObject)
/**  获取手机型号 eg: iphone6 iphoneX */
+ (NSString *)wl_getDeviceModel;

#pragma mark ___RuntimeKit___
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/** 获取成员变量，包括属性生成的成员变量 */
+ (NSArray *)wl_fetchIvarList;

/** 获取类的属性列表，包括私有和公有属性，也包括分类中的属性 */
+ (NSArray *)wl_fetchPropertyList;

/** 获取对象方法列表：包括getter, setter, 分类中的方法等 */
+ (NSArray *)wl_fetchInstanceMethodList;

/** 获取类方法列表 包括分类里面的 */
+ (NSArray *)wl_fetchClassMethodList;

/** 获取协议列表，包括.h .m 和分类里的 */
+ (NSArray *)wl_fetchProtocolList;

/** 添加一个方法 */
+ (void)wl_addMethod:(SEL)methodSel methodImp:(SEL)methodImp;

/**
 *  runtime替换实例函数
 */
+ (void)wl_exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2;

/**
 *  runtime替换静态函数
 */
+ (void)wl_exchangeClassMethod1:(SEL)method1 method2:(SEL)method2;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark ___RuntimeKit___

/**
 *  获取当前显示的viewcontroller
 *
 *  @return return 当前显示的vc
 */
+ (UIViewController *)wl_obtainTopViewController;

/**
 *  获取当前显示的viewcontroller
 *
 *  @return return 当前显示的vc
 */
- (UIViewController *)wl_obtainTopViewController;



/** 拨打电话 */
- (void)wl_callTelPhone:(NSString *)phoneNumber;

@end
