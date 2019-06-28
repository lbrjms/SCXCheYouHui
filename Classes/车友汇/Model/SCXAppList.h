//
//  SCXAppList.h
//  SCXiOS
//
//  Created by liuwj on 2019/1/11.
//  Copyright © 2019 wll. All rights reserved.
//

#import "BaseObject.h"
#import "SCXAppModel.h"
@interface SCXAppList : BaseObject
// 是否显示新品推荐
@property (nonatomic, assign)BOOL isNewShow;
// 新品推荐
@property (nonatomic, strong)NSArray<SCXAppModel *>* userAppsList;
@property (nonatomic, strong)NSArray<SCXAppModel *>* appsList;
@end
