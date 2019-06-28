//
//  CYHCollectionAppCell.h
//  SCXiOS
//
//  Created by liuwj on 2019/1/19.
//  Copyright © 2019 wll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCXAppModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol SCXAppAddOrSubtractDelegate

/**
 编辑或是完成
 
 @param model model
 */
- (void)addOrSubtractWithModel:(id)model;

@end
@interface CYHCollectionAppCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (retain, nonatomic)  SCXAppModel *model;
// 编辑状态的灰色view
@property (weak, nonatomic) IBOutlet UIView *editGrayView;
// 加号 或是 减号
@property (weak, nonatomic) IBOutlet UIButton *choseBtn;
// 是否是编辑状态
@property (nonatomic, assign)BOOL isEditing;
@property (nonatomic, assign)id<SCXAppAddOrSubtractDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
