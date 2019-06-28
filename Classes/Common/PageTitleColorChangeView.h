//
//  PageTitleColorChangeView.h
//  SCXiOS
//
//  Created by liuwj on 2019/1/14.
//  Copyright © 2019 wll. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PageTitleColorChangeViewDelegate
//@class PageContentView;
- (void)pageTitleColorChangeViewSelectedIndex:(NSInteger)index;
@end
@interface PageTitleColorChangeView : UIView
// MARK:- 定义属性
@property (nonatomic, weak)id<PageTitleColorChangeViewDelegate> delegate;
@property (nonatomic, assign)float scrollLineX;
@property (nonatomic, assign)NSInteger currentIndex;
@property (nonatomic, assign)float kScrollLineH;
@property (nonatomic, strong)NSArray<NSString *> * titles;
@property (nonatomic, strong)UIView * grayLineView;
// MARK:- 懒加载属性
@property (nonatomic, strong)NSMutableArray<UILabel *> * titleLabels;
@property (nonatomic, strong)UIScrollView * scrollView;
@property (nonatomic, strong)UIView * scrollLine ;
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;
- (void)setTitleWithProgress:(float)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex;

/**
 选中和不选中的时候的文字颜色
 */
@property (nonatomic, strong)UIColor * normalColor;
@property (nonatomic, strong)UIColor * selectColor;
@property (nonatomic, assign)float currentAlpha;

@end

NS_ASSUME_NONNULL_END
