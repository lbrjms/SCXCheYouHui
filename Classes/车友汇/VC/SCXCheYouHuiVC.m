//
//  SCXCheYouHuiVC.m
//  SCXiOS
//
//  Created by wll on 2019/1/8.
//  Copyright © 2019 wll. All rights reserved.
//

#import "SCXCheYouHuiVC.h"

#import "CYHCollectionAppCell.h"
#import "CYHSctionHeader.h"
#import "ImgTopTitleBottomBtn.h"
#import "CYHNetWorkManager.h"

@interface SCXCheYouHuiVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CYHAppEditDelegate,SCXAppAddOrSubtractDelegate>
@property (nonatomic, strong)UICollectionView *myCollectionView;
@property (nonatomic, strong)SCXAppList *homeModel;
// 我的应用
@property (nonatomic, strong)NSMutableArray *myAPPs;
// 车友汇
@property (nonatomic, strong)NSMutableArray *allAPPs;
// 是否是编辑状态
@property (nonatomic, assign)BOOL isEditing;

@end

@implementation SCXCheYouHuiVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.wl_bgColor = [UIColor whiteColor];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.myCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    self.navigationItem.title = @"车友汇";
    [self.navigationController.navigationBar wl_sepLineHidden:YES];
    [self initCollectionView];
    [self.view jcw_showGifLoading];
    [self netWork];
}

/**
 初始化collectionView
 */
- (void)initCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, (kScreenHeight-kTabbarHeight-kNavigationbarHeight)) collectionViewLayout:layout];
    _myCollectionView.delegate = self;
    _myCollectionView.dataSource = self;
    _myCollectionView.alwaysBounceVertical = YES;
    _myCollectionView.showsVerticalScrollIndicator = false;
    _myCollectionView.backgroundColor = [UIColor whiteColor];
    [_myCollectionView registerNib:[UINib nibWithNibName:@"CYHSctionHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CYHSctionHeaderID"];
    [_myCollectionView registerNib:[UINib nibWithNibName:@"CYHCollectionAppCell" bundle:nil] forCellWithReuseIdentifier:@"CYHCollectionAppCellID"];
    [_myCollectionView registerNib:[UINib nibWithNibName:@"HomeRecommendCell" bundle:nil] forCellWithReuseIdentifier:@"HomeRecommendCellID"];
    [self.view addSubview:_myCollectionView];

}
#pragma mark - UICollectionViewLayoutDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0) {
        return _myAPPs.count;
    }else{
        return _allAPPs.count;

    }
    
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(kScreenWidth, 40);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(kScreenWidth/4.0, 80);
 
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - UICollectionViewDataSource
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{

    CYHSctionHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CYHSctionHeaderID" forIndexPath:indexPath];
    headerView.delegate = self;
    if (indexPath.section==0) {
        headerView.title.text = @"我的应用";
        headerView.editBtn.selected = self.isEditing;
        if (self.isEditing) {
            headerView.editBtn.backgroundColor = [UIColor whiteColor];
            headerView.editBtn.layer.borderColor = [UIColor whiteColor].CGColor;
            
        }else{
            headerView.editBtn.backgroundColor = [UIColor colorWithHexString:@"#FEF0E4"];
            headerView.editBtn.layer.borderColor = Normal_ThemeColor.CGColor;
            
        }
    }else{
        headerView.title.text = @"车友汇";

    }
    headerView.editBtn.hidden = indexPath.section!=0;
    return headerView;
}


#pragma mark - UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CYHCollectionAppCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CYHCollectionAppCellID" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.isEditing = self.isEditing;
    cell.delegate = self;
    SCXAppModel *model = nil;
    if (indexPath.section==0) {
        model = _myAPPs[indexPath.item];
    }else{
        model = _allAPPs[indexPath.item];
    }
    model.index = indexPath;
    cell.model = model;
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
//        SCXAppModel *model = _homeModel.categoryList[indexPath.row];
//        [SCXRouter routerWithActionType:model.actionType actionUrl:model.actionUrl navigationController:self.navigationController];
        
    }else if (indexPath.section==1) {
        
    }else{
//        GoodsModel *model = _homeModel.goodsList[indexPath.item];
//        DetailVC *detail= [[DetailVC alloc] init];
//        detail.issuedNo = model.issuedNo;
//        [self.navigationController pushViewController:detail animated:YES];
    }
    
}
- (void)appEditingWithStatus:(BOOL)editing
{
    self.isEditing = editing;
    [self.myCollectionView reloadData];
}
- (void)addOrSubtractWithModel:(id)model
{
    SCXAppModel *models = model;
    if (models.isSubtract) {
        //
        [self.myAPPs removeObjectAtIndex:models.index.row];
    }else{
        [self.myAPPs addObject:models];
        models.isSubtract = YES;
    }
    
    [self.myCollectionView reloadData];
}
- (SCXAppList *)homeModel
{
    if (!_homeModel) {
        _homeModel = [[SCXAppList alloc] init];
    }
    return _homeModel;
}
- (NSMutableArray *)myAPPs
{
    if (!_myAPPs) {
        _myAPPs = [NSMutableArray array];
    }
    return _myAPPs;
}
- (NSMutableArray *)allAPPs
{
    if (!_allAPPs) {
        _allAPPs = [NSMutableArray array];
    }
    return _allAPPs;
}
/**
 数据请求
 */
- (void)netWork
{
    kWeakSelf(weakSelf, self);
    [CYHNetWorkManager getAppsuccess:^(SCXAppList * _Nonnull response) {
        
        [self.view hideHUDLoading:0];
        // 刷新界面
        
        weakSelf.homeModel = response;
      
        weakSelf.myAPPs = [NSMutableArray arrayWithArray:weakSelf.homeModel.userAppsList];
        for (SCXAppModel *model in weakSelf.myAPPs) {
            model.isSubtract = YES;
        }

        weakSelf.allAPPs = [NSMutableArray arrayWithArray:weakSelf.homeModel.appsList];
        for (SCXAppModel *model in weakSelf.allAPPs) {
            for (SCXAppModel *model2 in weakSelf.myAPPs) {
                if ([model.appID isEqualToString:model2.appID]) {
                    model.isSubtract = YES;
                }else{
                    model.isSubtract = NO;
                }
            }
        }
        [weakSelf.myCollectionView reloadData];
        
    } failure:^(NSString * _Nonnull errorMessage) {
        [weakSelf.myCollectionView reloadData];
        [weakSelf.view showHUDFailTips:errorMessage hideDelay:kSCXHUDHideDelay];
    }];
}


@end
