//
//  PayTool.m
//  Category
//
//  Created by 王乐乐 on 16/7/7.
//  Copyright © 2016年 Wanglele. All rights reserved.
//

#import "UIView+Additions.h"
#import "MBProgressHUD.h"
#import <SDWebImage/UIImage+GIF.h>
//TODO:打开即使用动画加载  为了兼容之前的showHUDLoading等api
//#define JCW_UseGifLoading

/** 获取gif动画图 */
UIImageView * jcw_getAnimationCunstomView(){
    UIImageView * gif = [[UIImageView alloc] init];
    NSMutableArray * temp = [@[] mutableCopy];
    for (NSInteger i = 1; i < 6; i ++) {
        [temp addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loading-%zd",i]]];
    }
    gif.animationImages = temp;
    gif.animationDuration = 0.9;
    [gif startAnimating];
    
//    UIImage *imgData = [UIImage imageNamed:@"cfloading@2x.gif"];
//    NSData *gifData = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"cfloading" ofType:@"gif"]];

//    NSData *data = UIImagePNGRepresentation(imgData);
//    gif.image = [UIImage sd_animatedGIFWithData:gifData];
    return  gif;
}

static AlertViewSelectBlock mBlock;
static UIControl *tempControl;

@implementation UIView (Additions)


/*****************************************************************************************************聪易投专用gif加载框***************************隐藏接口还用之前的**************************************************************/

/**
 * show 只动画
 */
- (void)jcw_showGifLoading{
#ifdef JCW_UseGifLoading  //动画加载框
    MBProgressHUD *mHUD = [self createHUD];
    mHUD.customView = jcw_getAnimationCunstomView();
    mHUD.tintColor = [UIColor clearColor];
    mHUD.mode = MBProgressHUDModeCustomView;
    mHUD.margin = 0;
    mHUD.bezelView.color = [UIColor clearColor];
    [mHUD showAnimated:NO];
#else
    MBProgressHUD *mHUD = [self createHUD];
    mHUD.mode = MBProgressHUDModeIndeterminate;
//    mHUD.label.text = theTips;
//    mHUD.detailsLabel.text = theDetail;
    [mHUD showAnimated:NO];
#endif
}

/**
 * show 只动画 自动隐藏时间
 */
- (void)jcw_showGifLoadingHideDelay:(NSTimeInterval)delayTime{
#ifdef JCW_UseGifLoading  //动画加载框
    MBProgressHUD *mHUD = [self createHUD];
    mHUD.customView = jcw_getAnimationCunstomView();
    mHUD.mode = MBProgressHUDModeCustomView;
    [mHUD showAnimated:NO];
    mHUD.margin = 0;
    mHUD.bezelView.color = [UIColor clearColor];
    [mHUD hideAnimated:YES afterDelay:delayTime];
#else
    MBProgressHUD *mHUD = [self createHUD];
    mHUD.mode = MBProgressHUDModeIndeterminate;
//    mHUD.label.text = theTips;
//    mHUD.detailsLabel.text = theDetail;
    [mHUD hideAnimated:YES afterDelay:delayTime];
#endif
}

/*****************************************************************************************************聪易投专用gif加载框***************************隐藏接口还用之前的*********************************************************/







-(MBProgressHUD*)createHUD
{
    @synchronized(self){
        MBProgressHUD *tempHUD = (MBProgressHUD*)[[UIApplication sharedApplication].keyWindow viewWithTag:HUDViewTagInSuperView];
        if (!tempHUD) {
            tempHUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
            tempHUD.removeFromSuperViewOnHide = YES;
            tempHUD.tag = HUDViewTagInSuperView;
            tempHUD.offset = CGPointMake(0, -20);
            tempHUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
            [[UIApplication sharedApplication].keyWindow addSubview:tempHUD];
        }
        return tempHUD;
    }
}

-(MBProgressHUD*)findHUD
{
    @synchronized(self){
        MBProgressHUD *tempHUD = (MBProgressHUD*)[[UIApplication sharedApplication].keyWindow viewWithTag:HUDViewTagInSuperView];
        if (!tempHUD) {
            for (MBProgressHUD *temp in [UIApplication sharedApplication].keyWindow.subviews) {
                if ([temp isKindOfClass:[MBProgressHUD class]]) {
                    tempHUD = temp;break;
                }
            }
        }
        
        return tempHUD;
    }
}


-(void)showHUDLoading
{
    [self showHUDLoadingTips:nil details:nil];
}

-(void)showHUDLoadingTips:(NSString*)theTips
{
    [self showHUDLoadingTips:theTips details:nil];
}

-(void)showHUDLoadingTips:(NSString*)theTips details:(NSString*)theDetail
{
#ifdef JCW_UseGifLoading  //动画加载框
    MBProgressHUD *mHUD = [self createHUD];
    mHUD.customView = jcw_getAnimationCunstomView();
    mHUD.mode = MBProgressHUDModeCustomView;
    mHUD.bezelView.color = [UIColor clearColor];
    mHUD.margin = 0;
    //动画加载的时候干掉 只要动画图
//    mHUD.label.text = theTips;
//    mHUD.detailsLabel.text = theDetail;
    [mHUD showAnimated:NO];
#else
    MBProgressHUD *mHUD = [self createHUD];
    mHUD.mode = MBProgressHUDModeIndeterminate;
    mHUD.label.text = theTips;
    mHUD.detailsLabel.text = theDetail;
    [mHUD showAnimated:NO];
#endif
}

-(MBProgressHUD *)showHUDProgressTips:(NSString *)theTips
{
    MBProgressHUD *mHUD = [self createHUD];
    mHUD.mode = MBProgressHUDModeAnnularDeterminate;
    mHUD.label.text = theTips;
    [mHUD showAnimated:NO];
    return mHUD;
}

-(void)hideHUDLoading:(NSTimeInterval)delayTime
{
    [[self findHUD] hideAnimated:YES afterDelay:delayTime];
}

-(void)showHUDSuccessTips:(NSString*)theTips hideDelay:(NSTimeInterval)delayTime
{
    UIImageView *imgview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-success"]];
    [self showHUDCustomView:imgview withTips:theTips hideDelay:delayTime];
}

-(void)showHUDFailTips:(NSString*)theTips hideDelay:(NSTimeInterval)delayTime
{
    UIImageView *imgview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-error"]];
    [self showHUDCustomView:imgview withTips:theTips hideDelay:delayTime];
}

-(void)showHUDWarnTips:(NSString*)theTips hideDelay:(NSTimeInterval)delayTime
{
    UIImageView *imgview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-info"]];
    [self showHUDCustomView:imgview withTips:theTips hideDelay:delayTime];
}

-(void)showHUDTextTips:(NSString*)theTips detail:(NSString*)theDetail hideDelay:(NSTimeInterval)delayTime
{
    MBProgressHUD *mHUD = [self createHUD];
    mHUD.mode = MBProgressHUDModeText;
    mHUD.label.text = theTips;
    mHUD.detailsLabel.text = theDetail;
    mHUD.margin = 10.f;
    mHUD.removeFromSuperViewOnHide = YES;
    [mHUD showAnimated:NO];
    [mHUD hideAnimated:YES afterDelay:delayTime];
    //    [self showHUDCustomView:nil withTips:theTips hideDelay:delayTime];
}


-(void)showHUDCustomView:(UIView*)theCustomView withTips:(NSString*)theTips hideDelay:(NSTimeInterval)delayTime
{
    MBProgressHUD *mHUD = [self createHUD];
    mHUD.customView = theCustomView;
    mHUD.mode = MBProgressHUDModeCustomView;;
    mHUD.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    mHUD.margin = 4;
    mHUD.label.textColor = [UIColor whiteColor];
    mHUD.label.text = theTips;
    mHUD.label.numberOfLines = 0;
    [mHUD showAnimated:NO];
    [mHUD hideAnimated:YES afterDelay:delayTime];
}


-(void)showHUDExcuteBlock:(void(^)(MBProgressHUD *hudView))exBlock complete:(void(^)(void))theBlock
{
#if NS_BLOCKS_AVAILABLE
    MBProgressHUD *mHUD = [self createHUD];
    
    [mHUD showAnimated:YES whileExecutingBlock:^{
        if (exBlock) { exBlock(mHUD); }
    } completionBlock:^{
        [mHUD removeFromSuperview];
        if (theBlock) { theBlock(); }
    }];
#endif
}

-(void)showHUDProgressBlock:(void(^)(MBProgressHUD *hudView))exBlock complete:(void(^)(void))theBlock
{
#if NS_BLOCKS_AVAILABLE
    MBProgressHUD *mHUD = [self createHUD];
    mHUD.mode = MBProgressHUDModeAnnularDeterminate;
    
    [mHUD showAnimated:YES whileExecutingBlock:^{
        if (exBlock) { exBlock(mHUD); }
    } completionBlock:^{
        [mHUD removeFromSuperview];
        if (theBlock) { theBlock(); }
    }];
#endif
}

//-(void)showHUDProgress
//{
//    MBProgressHUD *mHUD = [self createHUD];
//
//    mHUD.mode = MBProgressHUDModeDeterminate;
//    mHUD.progress = 0.8f;
//
//
//    mHUD.dimBackground = YES;
//    mHUD.color = [UIColor colorWithRed:0.23 green:0.50 blue:0.82 alpha:0.90];
//    [mHUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
//}
//
//- (void)myTask {
//	// This just increases the progress indicator in a loop
//    MBProgressHUD *hud = [self findHUD];
//    if (hud) {
//        float progress = 0.0f;
//        while (progress < 1.0f) {
//            progress += 0.01f;
//            [self findHUD].progress = progress;
//        }
//    }
//    usleep(50000);
//}


// -------------------------------

-(void)showAlertView:(NSString*)title withContent:(NSString*)content
{
    UIAlertView *alertv = [[UIAlertView alloc] initWithTitle:title?:@"   " message:content delegate:nil cancelButtonTitle:@"确  定" otherButtonTitles:nil,nil];
    alertv.tag = alertViewTagInSuperView;
    [alertv show];
}


-(void)showAlertViewSelect:(NSString*)title content:(NSString*)content choseBlock:(AlertViewSelectBlock)theBlock
{
    mBlock = theBlock;
    UIAlertView *alertv = [[UIAlertView alloc] initWithTitle:title?:@"   " message:content delegate:self cancelButtonTitle:@"取  消" otherButtonTitles:@"确  定",nil];
    alertv.tag = alertViewTagInSuperView;
    [alertv show];
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == alertViewTagInSuperView) {
        if (mBlock) {
            mBlock(buttonIndex==1);
            mBlock = nil;
        }
    }
}

-(void)showTextView:(NSString*)theContent
{
    if (!tempControl) {
        tempControl = [[UIControl alloc] initWithFrame:self.bounds];
        tempControl.backgroundColor = [UIColor colorWithWhite:0.4f alpha:0.6f];
        CGRect bRect = CGRectMake(0, 0, 240, 200);
        UITextView *textView = [[UITextView alloc] initWithFrame:bRect];
        textView.center = CGPointMake(tempControl.frame.size.width/2, tempControl.frame.size.height/2);
        textView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9f];
        textView.font = [UIFont systemFontOfSize:16];
        textView.editable = NO;
        textView.tag = 1024;
        
        textView.layer.borderWidth = 1;
        textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        textView.layer.cornerRadius = 4;
        
        [tempControl addSubview:textView];
        [tempControl addTarget:self action:@selector(hideTextView:) forControlEvents:UIControlEventTouchDown];
    }
    UITextView *textView = (UITextView *)[tempControl viewWithTag:1024];
    textView.text = theContent?:@"";
    tempControl.alpha = 0;
    [self addSubview:tempControl];
    [UIView animateWithDuration:0.28f animations:^{
        tempControl.alpha = 1;
    } completion:nil];
    
}

-(void)hideTextView:(UIControl*)theControl
{
    [UIView animateWithDuration:0.2f animations:^{
        theControl.alpha = 0;
    } completion:^(BOOL finished) {
        [theControl removeFromSuperview];
    }];
}

// -------------------------------

+(id)loadNibView:(NSString*)theNibName
{
    NSArray *viewArr = [[NSBundle mainBundle] loadNibNamed:theNibName owner:nil options:nil];
    if (viewArr.count>0) {
        return [viewArr firstObject];
    }
    return nil;
}

//- (void)async:(void(^)(void))block{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
//}
//
//- (void)async_main:(void(^)(void))block{
//    dispatch_async(dispatch_get_main_queue(), block);
//}
//
//-(BOOL)isLastIOS7
//{
//    return ([UIDevice currentDevice].systemVersion.floatValue >= 7.0);
//}
//
//-(BOOL)isLastIOS6
//{
//    return ([UIDevice currentDevice].systemVersion.floatValue >= 6.0);
//}
//
//-(float)getIOSVersion
//{
//    return [UIDevice currentDevice].systemVersion.floatValue;
//}

-(UIViewAutoresizing)getViewAllResizingMask
{
    return UIViewAutoresizingFlexibleLeftMargin|
    UIViewAutoresizingFlexibleWidth|
    UIViewAutoresizingFlexibleRightMargin|
    UIViewAutoresizingFlexibleTopMargin|
    UIViewAutoresizingFlexibleHeight|
    UIViewAutoresizingFlexibleBottomMargin;
}

















-(void)hudWasHidden:(MBProgressHUD *)hud
{
    
}


@end
