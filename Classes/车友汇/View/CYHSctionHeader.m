//
//  CYHSctionHeader.m
//  SCXiOS
//
//  Created by liuwj on 2019/1/16.
//  Copyright © 2019 wll. All rights reserved.
//

#import "CYHSctionHeader.h"

@implementation CYHSctionHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _editBtn.layer.borderColor = Normal_ThemeColor.CGColor;
    
}
- (IBAction)editingAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        sender.backgroundColor = [UIColor whiteColor];
        sender.layer.borderColor = [UIColor whiteColor].CGColor;
        [self.delegate appEditingWithStatus:YES];

    }else{
        sender.backgroundColor = [UIColor colorWithHexString:@"#FEF0E4"];
        sender.layer.borderColor = Normal_ThemeColor.CGColor;
        [self.delegate appEditingWithStatus:NO];

    }
}

@end
