//
//  PageContentView.h
//  SCXiOS
//
//  Created by liuwj on 2019/1/12.
//  Copyright © 2019 wll. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PageContentViewDelegate
//@class PageContentView;
- (void)pageProgress:(CGFloat)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex;
@end
@interface PageContentView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
// MARK:- 定义属性
@property (nonatomic, strong)NSArray<UIViewController *> *childVcs;
@property (nonatomic, weak)UIViewController * parentViewController;
@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, assign)float startOffsetX;

/**
 详情页的类似瀑布流效果
 */
@property (nonatomic, assign)BOOL cascadeFlowl;
/**
 用于区分是点击还滑动
 */
@property (nonatomic, assign)BOOL isForbidScrollDelegate;
@property (nonatomic, weak)id<PageContentViewDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame childVcs:(NSArray<UIViewController *>*)childVcs parentViewController:(UIViewController *)parentViewController;
- (void)setCurrentIndex:(NSInteger)index;
@end
