//
//  CYHCollectionAppCell.m
//  SCXiOS
//
//  Created by liuwj on 2019/1/19.
//  Copyright © 2019 wll. All rights reserved.
//

#import "CYHCollectionAppCell.h"

@implementation CYHCollectionAppCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _editGrayView.hidden = YES;
}
- (void)setModel:(SCXAppModel *)model
{
    
    _model = model;
  
    if (!_isEditing) {
        [UIView animateWithDuration:1 animations:^{
            //
            self->_editGrayView.alpha = 0;
        } completion:^(BOOL finished) {
            self->_editGrayView.hidden = YES;
        }];
    }else{
        _editGrayView.hidden = NO;

        [UIView animateWithDuration:1 animations:^{
            //
            self->_editGrayView.alpha = 1;
        } completion:^(BOOL finished) {
            self->_editGrayView.hidden = NO;
        }];

    }
   
    _title.text = model.title;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.iconUrl]];
    if (model.isSubtract) {
        [_choseBtn setImage:[UIImage imageNamed:@"app_subtract"] forState:UIControlStateNormal];
    }else{
         [_choseBtn setImage:[UIImage imageNamed:@"app_add"] forState:UIControlStateNormal];
    }
}
// 加或者减
- (IBAction)choseAction:(UIButton *)sender {
    SCXAppModel *modl = [SCXAppModel new];
    modl.isSubtract = _model.isSubtract;
    modl.title = _model.title;
    modl.iconUrl = _model.iconUrl;
    modl.index = _model.index;
    [self.delegate addOrSubtractWithModel:modl];
}
@end
