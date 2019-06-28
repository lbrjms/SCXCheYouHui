//
//  AccountModel.h
//  SCXiOS
//
//  Created by liuwj on 2019/1/12.
//  Copyright © 2019 wll. All rights reserved.
//

#import "BaseObject.h"

@interface AccountModel : BaseObject
@property (nonatomic, copy)NSString *isBidding;
@property (nonatomic, copy)NSArray *bannerList;
@property (nonatomic, copy)NSString *shareUrl;
@property (nonatomic, copy)NSString *helpUrl;

/**
 用户Id
 */
@property (nonatomic, copy)NSString * userId;

/**
 用户账号
 */
@property (nonatomic, copy)NSString * userAccount;

/**
 用户昵称
 */
@property (nonatomic, copy)NSString * userNickname;

/**
 用户头像信息
 */
@property (nonatomic, copy)NSString * userAvatar;

/**
 竞拍币
 */
@property (nonatomic, copy)NSString * biddingCurrency;

/**
 赠送币
 */
@property (nonatomic, copy)NSString * givingCurrency;

/**
 购物币
 */
@property (nonatomic, copy)NSString * shoppingCurrency;

/** 分享参数 */
@property (nonatomic, strong) id  actionUrl;
@end
