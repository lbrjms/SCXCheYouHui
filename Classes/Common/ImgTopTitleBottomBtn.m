//
//  ImgTopTitleBottomBtn.m
//  SCXiOS
//
//  Created by liuwj on 2019/1/11.
//  Copyright © 2019 wll. All rights reserved.
//

#import "ImgTopTitleBottomBtn.h"

@implementation ImgTopTitleBottomBtn

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initSubView];

}
- (void)drawRect:(CGRect)rect
{
    [self initSubView];

}
- (instancetype)init
{
    self = [super init];
    if (self) {

        [self initSubView];
    }
    return self;
}
/**
 设置图片在上 文字在下 居中显示
 */
- (void)initSubView
{
    //设置文字偏移：向下偏移图片高度＋向左偏移图片宽度 （偏移量是根据［图片］大小来的，这点是关键）
    self.titleEdgeInsets = UIEdgeInsetsMake( self.imageView.frame.size.height+8,  -self.imageView.frame.size.width,0,  0);
    
    //设置图片偏移：向上偏移文字高度＋向右偏移文字宽度 （偏移量是根据［文字］大小来的，这点是关键）
    self.imageEdgeInsets = UIEdgeInsetsMake(-self.titleLabel.bounds.size.height,  0,  5,  -self.titleLabel.bounds.size.width);

}
@end
