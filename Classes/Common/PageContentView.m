//
//  PageContentView.m
//  SCXiOS
//
//  Created by liuwj on 2019/1/12.
//  Copyright © 2019 wll. All rights reserved.
//

#import "PageContentView.h"
static NSString *  ContentCellID = @"ContentCellID";

@implementation PageContentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        // 2.创建UICollectionView
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = false;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollsToTop = NO;
        _collectionView.alwaysBounceVertical = true;
        if (@available(iOS 10.0, *)) {
            _collectionView.prefetchingEnabled = NO;
        }
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ContentCellID];
//        }
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
    }
    return _collectionView;
}
- (instancetype)initWithFrame:(CGRect)frame childVcs:(NSArray<UIViewController *>*)childVcs parentViewController:(UIViewController *)parentViewController
{
    self = [super initWithFrame:frame];
    if (self) {
        self.childVcs = childVcs;
        self.parentViewController = parentViewController;
        [self setUI];
    }
    return self;
}
- (void)setUI
{
    for (UIViewController *vc in _childVcs) {
        [_parentViewController addChildViewController:vc];
    }
    [self addSubview:self.collectionView];
    _collectionView.frame = self.bounds;
    _collectionView.backgroundColor = Normal_BgColor;

}
// MARK:- 遵守UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childVcs.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ContentCellID forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    UIViewController *childVC = self.childVcs[indexPath.item];

//    if (_cascadeFlowl&&indexPath.item !=0) {
//        CGRect rect = CGRectMake(0, navAddStatusHeight, 0, cell.contentView.bounds.size.height-navAddStatusHeight);
//
//        childVC.view.frame = rect;
//    }else{
        childVC.view.frame = cell.contentView.bounds;

//    }
//    childVC.view.frame = rect;

    [cell.contentView addSubview:childVC.view];
    return cell;
}
// MARK:- 遵守UICollectionViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _isForbidScrollDelegate = false;
    
    _startOffsetX = scrollView.contentOffset.x;
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 0.判断是否是点击事件
    if (_isForbidScrollDelegate) return;
    
    // 1.定义获取需要的数据
    float progress = 0;
    NSInteger sourceIndex = 0;
    NSInteger targetIndex = 0;
    
    // 2.判断是左滑还是右滑
    float currentOffsetX = scrollView.contentOffset.x;
    float scrollViewW = scrollView.bounds.size.width;
    if (currentOffsetX > _startOffsetX) { // 左滑
        // 1.计算progress
        progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW);
        
        // 2.计算sourceIndex
        sourceIndex = (currentOffsetX / scrollViewW);
        
        // 3.计算targetIndex
        targetIndex = sourceIndex + 1;
        if (targetIndex >= _childVcs.count) {
            targetIndex = _childVcs.count - 1;
        }
        
        // 4.如果完全划过去
        if (currentOffsetX - _startOffsetX == scrollViewW) {
            progress = 1;
            targetIndex = sourceIndex;
        }
    } else { // 右滑
        // 1.计算progress
        progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW));
        
        // 2.计算targetIndex
        targetIndex = (currentOffsetX / scrollViewW);
        
        // 3.计算sourceIndex
        sourceIndex = targetIndex + 1;
        if (sourceIndex >= _childVcs.count) {
            sourceIndex = _childVcs.count - 1;
        }
    }
    [self.delegate pageProgress:progress sourceIndex:sourceIndex targetIndex:targetIndex];
    
}
- (void)setCurrentIndex:(NSInteger)index
{
    // 1.记录需要进制执行代理方法
    _isForbidScrollDelegate = true;
    
    // 2.滚动正确的位置
    float offsetX = index * _collectionView.frame.size.width;
    [_collectionView setContentOffset:CGPointMake(offsetX, 0) animated:false];
}
@end
