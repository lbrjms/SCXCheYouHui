//
//  NetWorkUrl.h
//  SCXiOS
//
//  Created by liuwj on 2019/1/16.
//  Copyright © 2019 wll. All rights reserved.
//

#ifndef NetWorkUrl_h
#define NetWorkUrl_h
// http://coolcuii.eicp.net/system/parameters 阿里云oos参数

//#define IPHost @"http://coolcuii.eicp.net/"
//#define net_url(_str_) [[NSURL URLWithString:_str_ relativeToURL:[NSURL URLWithString:IPHost]] absoluteString]

#define net_url(_str_) [NSString stringWithFormat:@"%@",_str_]
/***************************************系统参数************************************/

// 系统参数获取/system/parameters GET
#define service_system net_url(@"system/parameters")
/***************************************首页************************************/

// 首页
#define service_home net_url(@"apps/list")
/***************************************我的************************************/

// 我的
#define service_my_account net_url(@"my/account")
// 设置
#define service_my_set net_url(@"my/account/reset")
// 修改个人信息
#define service_my_set_submit net_url(@"my/account/reset/submit")
/***************************************钱包************************************/

/**
 钱包明细
 pageNo    默认值1
 pageSize    默认值10
 type    交易类型：-1.所有；0.支出；1.收入；
 */
#define service_my_details net_url(@"my/account/details")
/***************************************订单************************************/

/**
 pageNo    no-required    默认值1
 pageSize    no-required    默认值10
 
 type        订单类型：-1.全部；0.待支付；1.待收货；2.已完成；
 */
#define service_my_order_list net_url(@"my/order/list")

/**
 确认收货
 token
 orderId        订单编号
 */
#define service_my_order_receipt net_url(@"my/order/receipt")
/**
 评价/晒单
 token
 orderId        订单编号
 content        评价内容
 imageUrl    no-required    评价图片：1.png；2.png；
 */
#define service_my_order_feedback net_url(@"my/order/feedback")
/***************************************收藏************************************/


/**
 我的收藏
 pageNo    默认值1
 pageSize    默认值10
 */
#define service_my_favorite_list net_url(@"my/favorite/list")
/**
 取消收藏
 token
  */
#define service_my_favorite_cancel net_url(@"my/favorite/cancel")
/***************************************地址************************************/
/**
 我的地址
 pageNo    默认值1
 pageSize    默认值10
 */
#define service_my_address_list net_url(@"my/address/list")
/**
 地址删除
 token
 addressId
 */
#define service_my_address_remove net_url(@"my/address/remove")
/**
 添加地址
 */
#define service_my_address_add net_url(@"my/address/add/init")

/**
 确认添加地址
 token
 addressList
 receiver    收件人
 mobile    手机号码
 regionId    省市区Id
 street    街道，详细地址；
 */
#define service_my_address_submit net_url(@"my/address/add/submit")

/**
 编辑地址
 addressId    地址编号
 */
#define service_my_address_modify net_url(@"my/address/modify/init")

/**
 确认编辑地址
 token
 addressId    地址编号
 receiver    收件人
 mobile    手机号码
 regionId    省市区Id
 street    街道，详细地址；
 */
#define service_my_address_modify_submit net_url(@"my/address/modify/submit")


/**
 获取省市区信息

 parentId 父类id
 */
#define service_my_address_region net_url(@"my/address/region")
/***************************************详情页************************************/
/**
 我的地址
 商品详情    /goods    POST
 goodsId    商品编号
 */
#define service_goods net_url(@"goods")

/**
 商品评价
 pageNo    默认值1
 pageSize    默认值10
 
 goodsId    商品编号
 */
#define service_goods_feedback net_url(@"goods/feedback")
/**
 往期成交
 pageNo    默认值1
 pageSize    默认值10
 
 goodsId    商品编号
 */
#define service_goods_history net_url(@"goods/history")
/**
 收藏商品
 token
 goodsId    商品编号
 */
#define service_goods_favorite net_url(@"goods/favorite")

/**
 竞拍出价
 token
 goodsId    商品编号
 出价次数    count    出价次数
 */
#define service_goods_bidding net_url(@"goods/bidding")
/**
 token
 goodsId    商品编号
 出价次数    count    出价次数
 */
#define service_next_bidding net_url(@"goods/nextBidding")






#endif /* NetWorkUrl_h */
