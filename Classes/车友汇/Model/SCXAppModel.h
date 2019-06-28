//
//  SCXAppModel.h
//  SCXiOS
//
//  Created by liuwj on 2019/1/11.
//  Copyright © 2019 wll. All rights reserved.
//

#import "BaseObject.h"

@interface SCXAppModel : BaseObject
//"id" : "1",
//"title" : "加油卡",
//"icon" : "https://download.scx365.com/apps/icon1.png",
//"actionType" : "toURL",
//"actionUrl" : "https://www.baidu.com"
@property (nonatomic, copy)NSString * iconUrl;
@property (nonatomic, copy)NSString * title;
@property (nonatomic, copy)NSString * appID;

/**
 toURL\toLogin\toAccount\toShare\toGoods\toCategory
 */
@property (nonatomic, copy)NSString * actionType;
@property (nonatomic, strong)id actionUrl;
// 用于编辑状态判断 加号 或是 减号
@property (nonatomic, assign)BOOL isSubtract;
// 索引 用于+ -
@property (nonatomic, retain)NSIndexPath* index;
@end
