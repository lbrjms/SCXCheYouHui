//
//  PageTitleView.h
//  SCXiOS
//
//  Created by liuwj on 2019/1/12.
//  Copyright © 2019 wll. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PageTitleViewDelegate
//@class PageContentView;
- (void)pageTitleViewSelectedIndex:(NSInteger)index;
@end
@interface PageTitleView : UIView
// MARK:- 定义属性
@property (nonatomic, assign)id<PageTitleViewDelegate> delegate;
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
@end
