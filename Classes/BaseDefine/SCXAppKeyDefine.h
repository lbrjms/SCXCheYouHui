//
//  SCXAppKeyDefine.h
//  SCXiOS
//
//  Created by wll on 2019/1/14.
//  Copyright © 2019 wll. All rights reserved.
//

#ifndef SCXAppKeyDefine_h
#define SCXAppKeyDefine_h

/** BaseUrl */
//#ifdef DEBUG
//
#define kSCXBaseUrl          @"http://coolcuii.eicp.net"
//
//#else

//#define kSCXBaseUrl          @"https://api.51yiyuangouwu.com"

//#endif

/** 用户sessionId */
#define kSCXUserSessionId    @"jsessionid"
/** 用户信息 */
#define kSCXUserInfoKey    @"kSCXUserInfoKey"


/** 防止接口重复提交的标识(后台起名为token) */
#define kSCXToken              @"token"
/** 加载框占位时间 */
#define kSCXHUDHideDelay     1


/** 渠道码 */
#define kSCXChannel_app      @"scx"

/** 开屏广告页数据key */
#define kSCXLaunchADInfoKey  @"kSCXLaunchADInfoKey"

//个推
#define kSCXGetuiAppid       @"qqtRfdkG696bbBEjWyjsn3"
#define kSCXGetuiAppkey      @"5yd91sZxie8SqE0pa5wjV9"
#define kSCXGetuiAppSecret   @"DRicS3we047O27DgpOQyG"
//MasterSecret： 后台使用
//Gikr21r2hn80nxq5HyNml4

#define kSCXGetuiClientId    @"kSCXGetuiClientId"


//友盟统计key
//#define kSCXUMSdkAppKey    @"5b330602b27b0a5ea1000021"

/////////////////////////////////分享默认参数配置////////////////////////
#define kSCXShareTitle         @"26935f18e96f0"
#define kSCXShareContent         @"26935f18e96f0"
#define kSCXShareImageUrl         @"26935f18e96f0"
#define kSCXShareUrl         @"26935f18e96f0"
/////////////////////////////////分享默认参数配置////////////////////////

//ShareSdk
#define kSCXShareSdkAppkey         @"26935f18e96f0"
//QQ
#define kSCXShareAppIdQQ           @"1108071627"
//QQ
#define kSCXShareAppKeyQQ          @"2C5Dt8okCXBiqWB5"
//WX
#define kSCXShareAppIdWeChatKey    @"wx9174dd0f62a88263"
//WX
#define kSCXShareAppSecretWeChat   @"25700b4cbf7841c565865b183236a61f"
//weibo
#define kSCXSinaWeiboAppKey @"1679174682"
//weibo
#define kSCXSinaWeiboAppSecret @"54d32a9129e0f687abbd5dd495356e84"
//weibo
#define kSCXShareSinaWeiboAppRedirect @"http://www.baidu.com"



#endif /* SCXAppKeyDefine_h */
