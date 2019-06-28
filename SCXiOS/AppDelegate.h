//
//  AppDelegate.h
//  SCXiOS
//
//  Created by wll on 2019/1/8.
//  Copyright © 2019 wll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)setRootVCForKeyWindowanimation:(BOOL)animation;

- (void)setRootVCForKeyWindowAnimation:(BOOL)animation tabbarSelectedIndex:(NSInteger)index;

@end

