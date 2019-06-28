//
//  PageTitleView.m
//  SCXiOS
//
//  Created by liuwj on 2019/1/12.
//  Copyright © 2019 wll. All rights reserved.
//

#import "PageTitleView.h"

@implementation PageTitleView
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titles = titles;
        [self setUI];
    }
    return self;
}

- (void)setUI{
    // 1.添加UIScrollView
    [self addSubview: self.scrollView];
    _scrollView.frame = self.bounds;
    _kScrollLineH = 2;
    _scrollLineX = 0;
    _currentIndex = 0;
    // 2.添加title对应的Label
    
    [self setupTitleLabels];
    // 3.设置底线和滚动的滑块
    [self setupBottomLineAndScrollLine];
}
- (void)setupTitleLabels
{
    // 0.确定label的一些frame的值
    float labelW  = self.frame.size.width / self.titles.count;
    float labelH  = self.frame.size.height - _kScrollLineH;
    float labelY  = 0;
    for (NSInteger index=0;index<_titles.count ; index++) {
        
        NSString * title = _titles[index];
        // 1.创建UILabel
        UILabel * label = [[UILabel alloc] init];
        // 2.设置Label的属性
        label.backgroundColor = Normal_whiteColor;
        label.text = title;
        label.tag = index;
        label.font = FONT_14;
        label.textColor = Normal_333Color;
        label.textAlignment = NSTextAlignmentCenter;
        // 3.设置label的frame
        float labelX  = labelW * index;
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        // 4.将label添加到scrollView中
        [_scrollView addSubview:label];
        [self.titleLabels addObject:label];
        
        // 5.给Label添加手势
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer * tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelClick:)];
        [label addGestureRecognizer:tapGes];
    }
}

- (void)setupBottomLineAndScrollLine
{
    // 1.添加底线
//    UIView * bottomLine = [[UIView alloc] init];
//    bottomLine.backgroundColor = Normal_BgColor;
//    float lineH  = 0.5;
//    bottomLine.frame = CGRectMake(0, self.frame.size.height-lineH, self.frame.size.width, lineH);
//            addSubview(bottomLine)
//    _ = grayLineView.sd_layout().bottomSpaceToView(scrollView,0.5)?.leftSpaceToView(scrollView,0)?.rightSpaceToView(scrollView,0)?.heightIs(0.5)
    // 2.添加scrollLine
    // 2.1.获取第一个Label
    if (_titleLabels.count>0) {
        UILabel *firstLab = _titleLabels[0];
        firstLab.textColor = Normal_ThemeColor;
        // 2.2.设置scrollLine的属性
        [_scrollView addSubview:self.scrollLine];
        _scrollLine.frame = CGRectMake(firstLab.frame.origin.x, self.frame.size.height-_kScrollLineH, firstLab.frame.size.width, _kScrollLineH);

    }
}
- (void)titleLabelClick:(UITapGestureRecognizer *)tapGes{
    // 0.获取当前Label
    UILabel * currentLabel = (UILabel *)tapGes.view ;
    if (!currentLabel)return;
    
    // 1.如果是重复点击同一个Title,那么直接返回
    if (currentLabel.tag == _currentIndex) return ;
    
    // 2.获取之前的Label
    UILabel * oldLabel = _titleLabels[_currentIndex];
    
    // 3.切换文字的颜色
    currentLabel.textColor = Normal_ThemeColor;
    oldLabel.textColor = Normal_333Color;
    
    // 4.保存最新Label的下标值
    _currentIndex = currentLabel.tag;
    
    // 5.滚动条位置发生改变
    _scrollLineX = _currentIndex * _scrollLine.frame.size.width;
    kWeakSelf(weakself, self);
    [UIView animateWithDuration:0.15 animations:^{
        //
        weakself.scrollLine.frame = CGRectMake(weakself.scrollLineX, weakself.scrollLine.frame.origin.y, weakself.scrollLine.frame.size.width, weakself.scrollLine.frame.size.height);

    }];
    // 6.通知代理
    [self.delegate pageTitleViewSelectedIndex:_currentIndex];
}
- (void)setTitleWithProgress:(float)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex
{
    // 1.取出sourceLabel/targetLabel
    UILabel * sourceLabel = _titleLabels[sourceIndex];
    UILabel * targetLabel = _titleLabels[targetIndex];
    
    // 2.处理滑块的逻辑
    float moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x;
    float moveX = moveTotalX * progress;
//    _scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
    _scrollLine.frame = CGRectMake(sourceLabel.frame.origin.x + moveX, _scrollLine.frame.origin.y, _scrollLine.frame.size.width, _scrollLine.frame.size.width);
    // 3.颜色的渐变(复杂)
    // 3.1.取出变化的范围
//    let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
    
    // 3.2.变化sourceLabel
    sourceLabel.textColor = Normal_333Color;
//    sourceLabel.textColor = UIColor(red: kSelectColor.0 - colorDelta.0 * progress, green: kSelectColor.1 - colorDelta.1 * progress, blue: kSelectColor.2 - colorDelta.2 * progress, alpha: 1)
    
    // 3.2.变化targetLabel
    targetLabel.textColor = Normal_ThemeColor;
//    targetLabel.textColor = UIColor(red: kNormalColor.0 + colorDelta.0 * progress, green: kNormalColor.1 + colorDelta.1 * progress, blue: kNormalColor.2 + colorDelta.2 * progress, alpha: 1)
    
    // 4.记录最新的index
    _currentIndex = targetIndex;
}
/**
 懒加载
 */
- (UIScrollView *)scrollView

{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollsToTop = NO;
        _scrollView.backgroundColor = Normal_CCCColor;
        _scrollView.bounces = NO;
    }
    return _scrollView;

}
- (UIView *)scrollLine

{
    if (!_scrollLine) {
        _scrollLine = [[UIView alloc] init];
        _scrollLine.backgroundColor = Normal_ThemeColor;
    }
    return _scrollLine;
}
- (NSMutableArray<UILabel *> *)titleLabels
{
    if (!_titleLabels) {
        _titleLabels = [NSMutableArray arrayWithCapacity:0];
    }
    return _titleLabels;
}
@end
