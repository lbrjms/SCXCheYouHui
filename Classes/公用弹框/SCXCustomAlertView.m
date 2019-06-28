//
//  SCXCustomAlertView.m
//  SCXiOS
//
//  Created by wll on 2019/1/28.
//  Copyright © 2019 wll. All rights reserved.
//

#import "SCXCustomAlertView.h"

@interface SCXCustomAlertView ()
{
    NSString * _titleText;
    NSString * _contentText;
    NSString * _contentImagNamed;
    NSString * _bottomLeftText;
    NSString * _bottomRightText;
    void(^_btnClickBlk)(SCXCustomAlertView * alertView,NSInteger btnIndex);
    CGFloat _contentViewWidth;
    NSAttributedString * _contentAttText;
}

@property (nonatomic, strong) UIView * contentV, * btnContainerV;

@end

@implementation SCXCustomAlertView

/** 标题 图片 按钮 回调（-1左  1右） */
+ (instancetype)showSelfWithTilte:(NSString *)titleText imgaeNamed:(NSString *)contentImageNamed bottomLeftTitle:(NSString *)bottomLeftBtnTitleText bottomRightTitle:(NSString *)bottomRightBtnTitleTrext btnClickBlk:(void(^)(SCXCustomAlertView * alertView,NSInteger btnIndex))btnClickBlk {
    
    return [[SCXCustomAlertView alloc] initWithTilte:titleText messageAttText:nil message:nil imgaeNamed:contentImageNamed bottomLeftTitle:bottomLeftBtnTitleText bottomRightTitle:bottomRightBtnTitleTrext btnClickBlk:btnClickBlk];
}

/** 标题 富文本内容 按钮 回调（-1左  1右） */
+ (instancetype)showSelfWithTilte:(NSString *)titleText messageAttText:(NSAttributedString *)contentAttText bottomLeftTitle:(NSString *)bottomLeftBtnTitleText bottomRightTitle:(NSString *)bottomRightBtnTitleTrext btnClickBlk:(void(^)(SCXCustomAlertView * alertView,NSInteger btnIndex))btnClickBlk {
    
    return [[SCXCustomAlertView alloc] initWithTilte:titleText messageAttText:contentAttText message:nil imgaeNamed:nil bottomLeftTitle:bottomLeftBtnTitleText bottomRightTitle:bottomRightBtnTitleTrext btnClickBlk:btnClickBlk];
}

/** 标题 内容 按钮 回调（-1左  1右） */
+ (instancetype)showSelfWithTilte:(NSString *)titleText message:(NSString *)contentText bottomLeftTitle:(NSString *)bottomLeftBtnTitleText bottomRightTitle:(NSString *)bottomRightBtnTitleTrext btnClickBlk:(void(^)(SCXCustomAlertView * alertView,NSInteger btnIndex))btnClickBlk {
    
    return [[SCXCustomAlertView alloc] initWithTilte:titleText messageAttText:nil message:contentText imgaeNamed:nil bottomLeftTitle:bottomLeftBtnTitleText bottomRightTitle:bottomRightBtnTitleTrext btnClickBlk:btnClickBlk];
}

/** btnIndex -1左按钮 1右按钮 */
- (instancetype)initWithTilte:(NSString *)titleText messageAttText:(NSAttributedString *)contentAttText message:(NSString *)contentText imgaeNamed:(NSString *)contentImageNamed bottomLeftTitle:(NSString *)bottomLeftBtnTitleText bottomRightTitle:(NSString *)bottomRightBtnTitleTrext btnClickBlk:(void(^)(SCXCustomAlertView * alertView,NSInteger btnIndex))btnClickBlk{
    if (self = [super init]) {
        _titleText = titleText;
        _contentAttText = contentAttText;
        _contentText = contentText;
        _contentImagNamed = contentImageNamed;
        _bottomLeftText = bottomLeftBtnTitleText;
        _bottomRightText = bottomRightBtnTitleTrext;
        _btnClickBlk = btnClickBlk;
        _contentViewWidth = 250;
        [self configUI];
    }
    return self;
}

/** 按钮点击事件 */
- (void)btnClick:(UIButton *)sender {
    //左-1 右1
    if (_btnClickBlk) {
        _btnClickBlk(self, sender.tag);
    }
}
/** 点击不响应事件的地方隐藏 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self hideSelf];
}

/** 显示放出来 后续可以添加相关动画 */
- (void)showSelf {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

/** 隐藏接口放出来 后续可以添加相关动画 */
- (void)hideSelf {
//    [self removeFromSuperview];
}

- (void)configUI {
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.frame = [UIScreen mainScreen].bounds;
    NSMutableParagraphStyle * pa = [NSMutableParagraphStyle new];
    pa.lineBreakMode = NSLineBreakByCharWrapping;
    pa.alignment = NSTextAlignmentCenter;
    
    [self addSubview:self.contentV];
    if (_titleText.length) {
        [self.contentV addSubview:self.titleLab];
        _titleLab.attributedText = [[NSAttributedString alloc] initWithString:_titleText attributes:@{NSFontAttributeName:_titleLab.font,NSForegroundColorAttributeName:_titleLab.textColor,NSParagraphStyleAttributeName:pa}];
    }
    if (_contentImagNamed.length) {
        [self.contentV addSubview:self.contentImageV];
        _contentImageV.image = [UIImage imageNamed:_contentImagNamed];
    }else {
        if (_contentAttText.length) {//有富文本
            [self.contentV addSubview:self.contentLab];
            _contentLab.attributedText = _contentAttText;
        }else {
            if (_contentText.length) {
                [self.contentV addSubview:self.contentLab];
                _contentLab.attributedText = [[NSAttributedString alloc] initWithString:_contentText attributes:@{NSFontAttributeName:_contentLab.font,NSForegroundColorAttributeName:_contentLab.textColor,NSParagraphStyleAttributeName:pa}];
            }
        }
    }
    
    [self.contentV addSubview:self.btnContainerV];
    
    if (_bottomLeftText.length) {
        [self.btnContainerV addSubview:self.bottomLeftBtn];
        [_bottomLeftBtn setTitle:_bottomLeftText forState:UIControlStateNormal];
    }
    if (_bottomRightText.length) {
        [self.btnContainerV addSubview:self.bottomRightBtn];
        [_bottomRightBtn setTitle:_bottomRightText forState:UIControlStateNormal];
    }
    
    [self showSelf];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //因为lab有内边距 所以spaceY 设置的小一点
    CGFloat spaceY = 15;
    CGFloat leftRightX = 25;
    CGFloat itemY = 0;
    CGFloat labW = _contentViewWidth - 2*leftRightX;
    if (_titleText.length) {//标题
        
        itemY += spaceY;
        CGFloat h = [self calculateTextHeightByTextView:self.titleLab.attributedText limitWidth:labW];;
        self.titleLab.frame = CGRectMake(leftRightX, itemY, labW, h);
        itemY += h;
    }
    
    
    if (_contentImagNamed.length) {//图片优先级最高
        
        itemY += spaceY;
        UIImage * image = [UIImage imageNamed:_contentImagNamed];
        self.contentImageV.frame = CGRectMake((_contentViewWidth-image.size.width)/2.0, itemY, image.size.width, image.size.height);
        itemY += image.size.height;
        
    }else {//文本
        
        if (_contentText.length || _contentAttText.length) {
            
            itemY += spaceY;
            CGFloat h = [self calculateTextHeightByTextView:self.contentLab.attributedText limitWidth:labW];
            self.contentLab.frame = CGRectMake(leftRightX, itemY, labW, h);
            itemY += h;
            
        }
    }
    
    
    itemY += spaceY;
    self.btnContainerV.frame = CGRectMake(0, itemY, _contentViewWidth, 50);
    itemY += 50;
    self.contentV.bounds = CGRectMake(0, 0, _contentViewWidth, itemY);
    self.contentV.center = self.center;
    
    if (_bottomLeftText.length && _bottomRightText.length) {//双按钮
        
        CGFloat btnW = (_contentViewWidth-0.5)/2.0;
        self.bottomLeftBtn.frame = CGRectMake(0, 0.5, btnW, 49.5);
        self.bottomRightBtn.frame = CGRectMake(btnW+0.5, 0.5, btnW, 49.5);
        
    }else if (_bottomLeftText.length) {//单左按钮
        
        self.bottomLeftBtn.frame = CGRectMake(0, 0.5, _contentViewWidth, 49.5);
        
    }else if (_bottomRightText.length) {//单右按钮
        
        self.bottomRightBtn.frame = CGRectMake(0, 0.5, _contentViewWidth, 49.5);
    }
    
}

/** 计算文本高度 */
- (CGFloat)calculateTextHeightByTextView:(NSAttributedString *)text limitWidth:(CGFloat)limitWidth {
    UITextView * tV = [[UITextView alloc] init];
    CGFloat padding = tV.textContainer.lineFragmentPadding;
    tV.textContainerInset = UIEdgeInsetsMake(0, -padding, 0, -padding);
    tV.attributedText = text;
    tV.bounds = CGRectMake(0, 0, limitWidth, 0);
    [tV sizeToFit];
    return tV.bounds.size.height;
}

////get
- (UIView *)contentV {
    if (!_contentV) {
        _contentV = [UIView new];
        _contentV.backgroundColor = [UIColor whiteColor];
        _contentV.layer.cornerRadius = 5;
        _contentV.clipsToBounds = YES;
    }
    return _contentV;
}

- (UIView *)btnContainerV {
    if (!_btnContainerV) {
        _btnContainerV = [UIView new];
        _btnContainerV.backgroundColor = UIColorFromRGB(0xf0f0f0);
    }
    return _btnContainerV;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.textColor = UIColorFromRGB(0x3d3d3d);
        _titleLab.font = [UIFont boldSystemFontOfSize:17];
    }
    return _titleLab;
}

- (UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [UILabel new];
        _contentLab.textAlignment = NSTextAlignmentCenter;
        _contentLab.textColor = UIColorFromRGB(0x757778);
        _contentLab.font = [UIFont systemFontOfSize:15];
        _contentLab.numberOfLines = 0;
        _contentLab.lineBreakMode = NSLineBreakByCharWrapping;
    }
    return _contentLab;
}

- (UIImageView *)contentImageV {
    if (!_contentImageV) {
        _contentImageV = [UIImageView new];
    }
    return _contentImageV;
}

- (UIButton *)bottomLeftBtn {
    if (!_bottomLeftBtn) {
        _bottomLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bottomLeftBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_bottomLeftBtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        _bottomLeftBtn.adjustsImageWhenHighlighted = NO;
        _bottomLeftBtn.backgroundColor = [UIColor whiteColor];
        _bottomLeftBtn.tag = -1;
        [_bottomLeftBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomLeftBtn;
}

- (UIButton *)bottomRightBtn {
    if (!_bottomRightBtn) {
        _bottomRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bottomRightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [_bottomRightBtn setTitleColor:Normal_ThemeColor forState:UIControlStateNormal];
        _bottomRightBtn.adjustsImageWhenHighlighted = NO;
        _bottomRightBtn.backgroundColor = [UIColor whiteColor];
        _bottomRightBtn.tag = 1;
        [_bottomRightBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomRightBtn;
}


@end
