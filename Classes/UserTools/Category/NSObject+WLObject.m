//
//  NSObject+WLObject.m
//  Yunmafu
//
//  Created by 王乐乐 on 2017/2/21.
//  Copyright © 2017年 wanglele. All rights reserved.
//

#import "NSObject+WLObject.h"
#import <UIKit/UIKit.h>
#import <objc/message.h>
#import "sys/utsname.h"

@implementation NSObject (WLObject)

/**  获取手机型号 eg: iphone6 iphoneX */
+ (NSString *)wl_getDeviceModel{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return deviceString;
}


#pragma mark ___RuntimeKit___
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSArray *)wl_fetchIvarList{
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(self, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
        const char *ivarName = ivar_getName(ivarList[i]);
        const char *ivarType = ivar_getTypeEncoding(ivarList[i]);
        dic[@"type"] = [NSString stringWithUTF8String:ivarType];
        dic[@"ivarName"] = [NSString stringWithUTF8String:ivarName];
        
        [mutableList addObject:dic];
    }
    free(ivarList);
    return [NSArray arrayWithArray:mutableList];
}

+ (NSArray *)wl_fetchPropertyList{
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList(self, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++)
    {
        const char *propertyName = property_getAttributes(propertyList[i]);
        [mutableList addObject:[NSString stringWithUTF8String:propertyName]];
    }
    free(propertyList);
    return [NSArray arrayWithArray:mutableList];
}

+ (NSArray *)wl_fetchInstanceMethodList{
    unsigned int count = 0;
    Method *methodList = class_copyMethodList(self, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++)
    {
        Method method = methodList[i];
        SEL methodName = method_getName(method);
        [mutableList addObject:NSStringFromSelector(methodName)];
    }
    free(methodList);
    return [NSArray arrayWithArray:mutableList];
}

+ (NSArray *)wl_fetchClassMethodList{
    unsigned int count = 0;
    Method *methodList = class_copyMethodList(object_getClass(self), &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++)
    {
        Method method = methodList[i];
        SEL methodName = method_getName(method);
        [mutableList addObject:NSStringFromSelector(methodName)];
    }
    free(methodList);
    return [NSArray arrayWithArray:mutableList];
}

+ (NSArray *)wl_fetchProtocolList{
    unsigned int count = 0;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList(self, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++ )
    {
        Protocol *protocol = protocolList[i];
        const char *protocolName = protocol_getName(protocol);
        [mutableList addObject:[NSString stringWithUTF8String:protocolName]];
    }
    
    return [NSArray arrayWithArray:mutableList];
}

+ (void)wl_addMethod:(SEL)methodSel methodImp:(SEL)methodImp;{
    Method method = class_getInstanceMethod(self, methodImp);
    IMP methodIMP = method_getImplementation(method);
    const char *types = method_getTypeEncoding(method);
    class_addMethod(self, methodSel, methodIMP, types);
}

+ (void)wl_exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2{
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}

+ (void)wl_exchangeClassMethod1:(SEL)method1 method2:(SEL)method2{
    method_exchangeImplementations(class_getClassMethod(self, method1), class_getClassMethod(self, method2));
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark ___RuntimeKit___

/**
 *  获取当前显示的viewcontroller
 *
 *  @return return 当前显示的vc
 */
+ (UIViewController *)wl_obtainTopViewController{
    return [[[UIViewController alloc] init] wl_obtainTopViewController];
}

/**
 *  获取当前显示的viewcontroller
 *
 *  @return return 当前显示的vc
 */
- (UIViewController *)wl_obtainTopViewController{
    return [self wl_obtainTopViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}
- (UIViewController*)wl_obtainTopViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self wl_obtainTopViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self wl_obtainTopViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self wl_obtainTopViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

/** 拨打电话 */
- (void)wl_callTelPhone:(NSString *)phoneNumber{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNumber]]];
}

@end
