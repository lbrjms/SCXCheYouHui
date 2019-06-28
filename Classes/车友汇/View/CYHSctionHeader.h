//
//  CYHSctionHeader.h
//  SCXiOS
//
//  Created by liuwj on 2019/1/16.
//  Copyright © 2019 wll. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol CYHAppEditDelegate

/**
 编辑或是完成

 @param editing yes 代表编辑状态
 */
- (void)appEditingWithStatus:(BOOL)editing;

@end
@interface CYHSctionHeader : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (nonatomic, assign)id<CYHAppEditDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
