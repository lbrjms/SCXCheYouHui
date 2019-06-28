//
//  SCXCheYouHuiVC.h
//  SCXiOS
//
//  Created by wll on 2019/1/8.
//  Copyright © 2019 wll. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 分类界面 */
@interface SCXCheYouHuiVC : UIViewController


/**
 传入指定的categoryId 如果还存在就跳转到这个分类
 */
@property (nonatomic, copy) NSString * categoryId;

@end
