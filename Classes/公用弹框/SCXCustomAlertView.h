//
//  SCXCustomAlertView.h
//  SCXiOS
//
//  Created by wll on 2019/1/28.
//  Copyright © 2019 wll. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 弹框视图 支持 1.标题内容单(双) 按钮 2.标题图片单(双)按钮  高度自适应(文本或者图片)  宽度(250) */
@interface SCXCustomAlertView : UIView

/** 标题 图片 按钮 回调（-1左  1右） */
+ (instancetype)showSelfWithTilte:(NSString *)titleText imgaeNamed:(NSString *)contentImageNamed bottomLeftTitle:(NSString *)bottomLeftBtnTitleText bottomRightTitle:(NSString *)bottomRightBtnTitleTrext btnClickBlk:(void(^)(SCXCustomAlertView * alertView,NSInteger btnIndex))btnClickBlk;

/** 标题 内容 按钮 回调（-1左  1右） */
+ (instancetype)showSelfWithTilte:(NSString *)titleText message:(NSString *)contentText bottomLeftTitle:(NSString *)bottomLeftBtnTitleText bottomRightTitle:(NSString *)bottomRightBtnTitleTrext btnClickBlk:(void(^)(SCXCustomAlertView * alertView,NSInteger btnIndex))btnClickBlk;

/** 标题 富文本内容 按钮 回调（-1左  1右） */
+ (instancetype)showSelfWithTilte:(NSString *)titleText messageAttText:(NSAttributedString *)contentAttText bottomLeftTitle:(NSString *)bottomLeftBtnTitleText bottomRightTitle:(NSString *)bottomRightBtnTitleTrext btnClickBlk:(void(^)(SCXCustomAlertView * alertView,NSInteger btnIndex))btnClickBlk;

/** 底部左右按钮 根据传入标题创建 标题为空就不新建 */
@property (nonatomic, strong) UIButton * bottomLeftBtn, * bottomRightBtn;

/** 默认图片优先级比较高 有图片 就不展示内容提示文本 */
@property (nonatomic, strong) UIImageView * contentImageV;

@property (nonatomic, strong) UILabel * titleLab, * contentLab;

/** 隐藏接口放出来 后续可以添加相关动画 */
- (void)hideSelf;

@end
