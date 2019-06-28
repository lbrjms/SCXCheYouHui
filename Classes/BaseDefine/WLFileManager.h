//
//  WLFileManager.h
//  Kangyx
//
//  Created by 王乐乐 on 16/9/12.
//  Copyright © 2016年 Wanglele. All rights reserved.
//

#import "BaseObject.h"

@interface WLFileManager : BaseObject

/*
 *  把对象归档存到沙盒里
 */
+ (void)saveObject:(id)object byFileName:(NSString*)fileName;

/*
 *  通过文件名从沙盒中找到归档的对象
 */
+ (id)getObjectByFileName:(NSString*)fileName;

/*
 *  根据文件名删除沙盒中的 plist 文件
 */
+ (void)removeFileByFileName:(NSString*)fileName;

/*
 *  存储用户偏好设置 到 NSUserDefults
 */
+ (void)saveUserData:(id)data forKey:(NSString*)key;

/*
 *  读取用户偏好设置
 */
+ (id)readUserDataForKey:(NSString*)key;

/*
 *  删除用户偏好设置
 */
+ (void)removeUserDataForkey:(NSString*)key;

@end
